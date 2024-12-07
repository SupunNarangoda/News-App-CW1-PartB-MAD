import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coursework1_partb_mad/Model/article_model.dart';

class ApiService {

  Future<List<Article>> getArticles() async {
    const String endPoint = "https://newsapi.org/v2/top-headlines?country=us&apiKey=616d48e0ce8b490a89a57a29db681fc4";
    final response = await http.get(Uri.parse(endPoint));

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      final article = body['articles'] as List<dynamic>? ?? [];

      final List<Article> data = [];
      for (final item in article) {
        if (item is Map<String, dynamic>) {
          try {
            data.add(Article.fromJson(item));
          } catch (error) {
            print('Failed to add article: $error');
          }
        }
      }
      return data;
    } else {
      throw Exception(response.statusCode);
    }
  }


  Future<List<Article>> getCatagoryArticles(String category) async {
    String endPoint = "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=616d48e0ce8b490a89a57a29db681fc4";
    final response = await http.get(Uri.parse(endPoint));

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      final article = body['articles'] as List<dynamic>? ?? [];

      final List<Article> data = [];
      for (final item in article) {
        if (item is Map<String, dynamic>) {
          try {
            data.add(Article.fromJson(item));
          } catch (e) {
            print('Failed to parse article: $e');
          }
        }
      }
      return data;
    } else {
      throw Exception(response.statusCode);
    }
  }


  Future<List<Article>> getSearchedArticles(String search) async {
    String endPoint = "https://newsapi.org/v2/everything?q=$search&apiKey=616d48e0ce8b490a89a57a29db681fc4";
    final response = await http.get(Uri.parse(endPoint));

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      final article = body['articles'] as List<dynamic>? ?? [];

      final List<Article> data = [];
      for (final item in article) {
        if (item is Map<String, dynamic>) {
          try {
            data.add(Article.fromJson(item));
          } catch (e) {
            print('Failed to parse article: $e');
          }
        }
      }
      return data;
    } else {
      throw Exception(response.statusCode);
    }
  }
}



