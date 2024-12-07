class Article{
  final String? author;
  final String title;
  final String description;
  final String? urlToImage;
  final String? content;
  final DateTime publishedAt;


  Article({
    this.author,
    required this.title,
    required this.description,
    this.urlToImage,
    this.content,
    required this.publishedAt
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        author: json['author'] as String?,
        title: json['title'] as String,
        description: json['description'] as String,
        urlToImage: json['urlToImage'] as String?,
        content: json['content'] as String?,
        publishedAt: DateTime.parse(json['publishedAt']),

    );
  }

}