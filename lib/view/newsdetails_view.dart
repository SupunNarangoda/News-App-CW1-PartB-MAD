import 'package:flutter/material.dart';
import 'package:coursework1_partb_mad/Model/article_model.dart';

class NewsDescriptionPage extends StatelessWidget {
  final Article article;
  const NewsDescriptionPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the article image or a placeholder
            Image.network(
              article.urlToImage ?? 'https://via.placeholder.com/150',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            // Show the title of the article
            Text(
              article.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Show the author if available
            if (article.author != null)
              Text(
                'Author: ${article.author}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            const SizedBox(height: 10),
            // Show the article content
            Text(
              article.content ?? 'Content not available',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            // Show the article description
            Text(
              article.description ?? 'Description not available',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
