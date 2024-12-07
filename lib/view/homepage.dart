import 'package:flutter/material.dart';
import 'package:coursework1_partb_mad/widgets/newscard.dart';
import 'package:coursework1_partb_mad/Model/article_model.dart';
import 'bookmark_view.dart';
import 'package:coursework1_partb_mad/view/search_view.dart';
import 'package:coursework1_partb_mad/view/category_view.dart';
import 'package:coursework1_partb_mad/view/catogorygrid_view.dart';
import 'package:provider/provider.dart';
import 'package:coursework1_partb_mad/providers/news_provider.dart';

class HomePage extends StatelessWidget {
  final List<Article> articles;
  const HomePage({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewsProvider()..initializeArticles(articles),
      child: HomePageChild(),
    );
  }
}


class HomePageChild extends StatelessWidget {

  final List<String> sortOptions = ['Alphabetical', 'Newest', 'Oldest'];

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    List<Widget> pages = [
      buildNewsList(context),
      BookmarksPage(),
      // SearchPage(articles: widget.articles),
      SearchPage(),
      // CategoryPage(),
      CategoryGridPage(),

    ];

    return Scaffold(
      body: pages[newsProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: newsProvider.currentIndex,
        onTap: (index) => newsProvider.updateCurrentIndex(index),
        backgroundColor: Colors.black,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Bookmarks'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category'),
        ],
      ),
    );
  }


  Widget buildNewsList(context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('News App'),
          floating: true,
          pinned: false,
          snap: true,
          actions: [
            DropdownButton<String>(
              value: null,
              hint: const Row(
                children: [
                  Icon(Icons.sort, color: Colors.white),
                  SizedBox(width: 10),
                  Text("Sort", style: TextStyle(color: Colors.black)),
                ],
              ),
              onChanged: (String? newValue) {
                newsProvider.sortArticles(newValue!);
              },
              items: sortOptions.map((option) {
                return DropdownMenuItem(value: option, child: Text(option));
              }).toList(),
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              return NewsCardWidget(article: newsProvider.displayedArticles[index]);
            },
            childCount: newsProvider.displayedArticles.length,
          ),
        ),
      ],
    );
  }
}


