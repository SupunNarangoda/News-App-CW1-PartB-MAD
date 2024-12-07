import 'package:flutter/material.dart';
import 'package:coursework1_partb_mad/Model/article_model.dart';
import 'package:coursework1_partb_mad/view/newsdetails_view.dart';
import 'package:coursework1_partb_mad/view/bookmark_view.dart';
import 'package:coursework1_partb_mad/controllers/bookmark_controller.dart';

class NewsCardWidget extends StatefulWidget {
  final Article article;
  const NewsCardWidget({super.key, required this.article});

  static List<Article> bookmarkedArticles = [];

  @override
  NewsCardWidgetState createState() => NewsCardWidgetState();
}

class NewsCardWidgetState extends State<NewsCardWidget> {
  // bool get isBookmarked => NewsCardWidget.bookmarkedArticles.contains(widget.article);
  final BookmarkController _bookmarkController = BookmarkController();
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    checkIfBookmarked();
  }

  Future<void> checkIfBookmarked() async {
    final result = await _bookmarkController.isBookmarked(widget.article.title);
    setState(() {
      isBookmarked = result;
    });
  }

  Future<void> toggleBookmark() async {
    if (isBookmarked) {
      await _bookmarkController.removeBookmark(widget.article.title);
    } else {
      await _bookmarkController.addBookmark(widget.article);
    }
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDescriptionPage(article: widget.article),
          ),
        );
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  widget.article.urlToImage ?? 'https://coffective.com/wp-content/uploads/2018/06/default-featured-image.png.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey,
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 50),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: toggleBookmark,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.article.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.article.description ?? 'No description available',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




