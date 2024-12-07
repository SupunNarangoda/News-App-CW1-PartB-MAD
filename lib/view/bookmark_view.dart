// import 'package:flutter/material.dart';
// import 'package:coursework1_partb_mad/Model/article_model.dart';
// import 'package:coursework1_partb_mad/view/newsdetails_view.dart';
// import 'package:coursework1_partb_mad/widgets/newscard.dart';
//
// class BookmarksPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final bookmarkedArticles = NewsCardWidget.bookmarkedArticles;
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Bookmarks')),
//       body: bookmarkedArticles.isEmpty
//           ? const Center(child: Text('No bookmarks added yet.'))
//           : ListView.builder(
//         itemCount: bookmarkedArticles.length,
//         itemBuilder: (context, index) {
//           final article = bookmarkedArticles[index];
//           return ListTile(
//             leading: article.urlToImage != null
//                 ? Image.network(article.urlToImage!, width: 50, fit: BoxFit.cover)
//                 : const Icon(Icons.broken_image),
//             title: Text(article.title),
//             subtitle: Text(article.description ?? 'No description'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => NewsDescriptionPage(article: article),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:coursework1_partb_mad/Model/article_model.dart';
// import 'package:coursework1_partb_mad/view/newscard.dart';
//
// class BookmarksPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final bookmarkedArticles = NewsCardWidget.bookmarkedArticles;
//
//     return Scaffold(
//       body: bookmarkedArticles.isEmpty
//           ? const Center(child: Text('No bookmarks added yet.'))
//           : ListView.builder(
//         itemCount: bookmarkedArticles.length,
//         itemBuilder: (context, index) {
//           return NewsCardWidget(article: bookmarkedArticles[index]);
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:coursework1_partb_mad/services/bookmark_controller.dart';
import 'package:coursework1_partb_mad/Model/article_model.dart';
import 'package:coursework1_partb_mad/widgets/newscard.dart';

class BookmarksPage extends StatelessWidget {
  final BookmarkController _bookmarkController = BookmarkController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BookMarks')),
      body: FutureBuilder<List<Article>>(
        future: _bookmarkController.getBookmarks(),
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

