import 'package:flutter/material.dart';
import 'package:coursework1_partb_mad/Model/article_model.dart';
import 'package:coursework1_partb_mad/services/article_controller.dart';
import 'package:coursework1_partb_mad/widgets/newscard.dart';

class CategoryNewsPage extends StatefulWidget {
  final String categoryName;

  CategoryNewsPage({required this.categoryName});

  @override
  _CategoryNewsPageState createState() => _CategoryNewsPageState();
}

class _CategoryNewsPageState extends State<CategoryNewsPage> {
  late Future<List<Article>> _articlesFuture;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _articlesFuture = _apiService.getCatagoryArticles(widget.categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.categoryName} News'),
      ),
      body: FutureBuilder<List<Article>>(
        future: _articlesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }  else {
            final articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return NewsCardWidget(article: articles[index]);
              },
            );
          }
        },
      ),
    );
  }
}
