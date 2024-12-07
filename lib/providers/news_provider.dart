import 'package:flutter/material.dart';
import 'package:coursework1_partb_mad/Model/article_model.dart';

class NewsProvider with ChangeNotifier {
  List<Article> articles = [];
  List<Article> _displayedArticles = [];
  int currentIndex = 0;


  List<Article> get displayedArticles => _displayedArticles;

  void initializeArticles(List<Article> articles) {
    articles = articles;
    _displayedArticles = List.from(articles);
    notifyListeners();
  }
  void updateCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
  void sortArticles(String criteria) {
    if (criteria == 'Alphabetical') {
      _displayedArticles.sort((a, b) => a.title.compareTo(b.title));
    } else if (criteria == 'Newest') {
      _displayedArticles.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
    } else if (criteria == 'Oldest') {
      _displayedArticles.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
    }
    notifyListeners();
  }
}
