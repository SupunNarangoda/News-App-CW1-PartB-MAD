import 'package:flutter/material.dart';
import 'package:coursework1_partb_mad/controllers/bookmark_controller.dart';
import 'package:coursework1_partb_mad/Model/article_model.dart';
import 'package:coursework1_partb_mad/widgets/newscard.dart';

class BookmarksPage extends StatelessWidget {
  final BookmarkController bookmarkController = BookmarkController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BookMarks')),
      body: FutureBuilder<List<Article>>(
        future: bookmarkController.getBookmarks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No bookmarks added yet.'));
          } else {
            final bookmarks = snapshot.data!;
            return ListView.builder(
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                return NewsCardWidget(article: bookmarks[index]);
              },
            );
          }
        },
      ),
    );
  }
}


