import 'package:flutter/material.dart';
import 'package:coursework1_partb_mad/widgets/newscard.dart';
import 'package:coursework1_partb_mad/Model/article_model.dart';
import 'bookmark_view.dart';
import 'package:coursework1_partb_mad/view/search_view.dart';
import 'package:coursework1_partb_mad/view/category_view.dart';
import 'package:coursework1_partb_mad/view/catogorygrid_view.dart';



class HomePage extends StatefulWidget {
  final List<Article> articles;
  const HomePage({super.key, required this.articles});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int currentIndex = 0;
  late List<Article> _displayedArticles;

  @override
  void initState() {
    super.initState();
    _displayedArticles = widget.articles; // Initialize articles
  }

  // Sorting logic
  void _sortArticles(String criteria) {
    setState(() {
      if (criteria == 'Alphabetical') {
        _displayedArticles.sort((a, b) => a.title.compareTo(b.title));
      } else if (criteria == 'Newest') {
        _displayedArticles.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
      } else if (criteria == 'Oldest') {
        _displayedArticles.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
      }
    });
  }


  final List<String> sortOptions = ['Alphabetical', 'Newest', 'Oldest'];

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      _buildNewsList(),
      BookmarksPage(),
      // SearchPage(articles: widget.articles),
      SearchPage(),
      // CategoryPage(),
      CategoryGridPage(),

    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        backgroundColor: Colors.black, // Set the background color to black
        selectedItemColor: Colors.grey, // Set selected item color for contrast
        unselectedItemColor: Colors.grey, // Set unselected item color for visibility
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Bookmarks'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category'),
        ],
      ),
    );
  }


  Widget _buildNewsList() {
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
                if (newValue != null) _sortArticles(newValue);
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
              return NewsCardWidget(article: _displayedArticles[index]);
            },
            childCount: _displayedArticles.length,
          ),
        ),
      ],
    );
  }
}

