import 'package:flutter/material.dart';
import 'package:coursework1_partb_mad/Model/article_model.dart';
import 'package:coursework1_partb_mad/services/article_controller.dart';
import 'package:coursework1_partb_mad/widgets/newscard.dart';
import 'package:coursework1_partb_mad/view/homepage.dart';
import 'view/newsdetails_view.dart';
import 'package:coursework1_partb_mad/providers/news_provider.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final ApiService apiService = ApiService();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<List<Article>>(
        future: apiService.getArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text('Failed to load articles: ${snapshot.error}')),
            );
          }  else {
            return HomePage(articles: snapshot.data!);
          }
        },
      ),
    );
  }
}
