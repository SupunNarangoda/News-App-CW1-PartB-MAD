import 'package:flutter/material.dart';
import 'package:coursework1_partb_mad/Model/article_model.dart';
import 'package:coursework1_partb_mad/widgets/newscard.dart';
import 'package:coursework1_partb_mad/services/article_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final ApiService apiService = ApiService();
  String _searchQuery = '';
  late Future<List<Article>> _searchedArticlesFuture;

  @override
  void initState() {
    super.initState();
    _searchedArticlesFuture = Future.value([]);
  }

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query.trim();
      _searchedArticlesFuture = _searchQuery.isNotEmpty
          ? apiService.getSearchedArticles(_searchQuery)
          : Future.value([]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Articles'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _performSearch,
              decoration: InputDecoration(
                hintText: 'Search for articles',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black87),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Article>>(
              future: _searchedArticlesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                final articles = snapshot.data;
                if (articles == null || articles.isEmpty) {
                  return const Center(
                    child: Text(
                      'No articles found.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return NewsCardWidget(article: articles[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

