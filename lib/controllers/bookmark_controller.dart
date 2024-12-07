import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Model/article_model.dart';

class BookmarkController {
  static final BookmarkController instance = BookmarkController._internal();
  static Database? _database;

  BookmarkController._internal();

  factory BookmarkController() => instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'bookmarks.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE bookmarks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            urlToImage TEXT,
            publishedAt TEXT,
            author TEXT,
            content TEXT
          )
        ''');
      },
    );
  }

  Future<void> addBookmark(Article article) async {
    final db = await database;
    await db.insert('bookmarks', {
      'title': article.title,
      'description': article.description,
      'urlToImage': article.urlToImage,
      'publishedAt': article.publishedAt.toIso8601String(),
      'author': article.author,
      'content': article.content,
    });
  }

  Future<void> removeBookmark(String title) async {
    final db = await database;
    await db.delete('bookmarks', where: 'title = ?', whereArgs: [title]);
  }

  Future<List<Article>> getBookmarks() async {
    final db = await database;
    final List<Map<String, dynamic>> bookmarkList = await db.query('bookmarks');
    return List.generate(bookmarkList.length, (i) {
      return Article(
        title: bookmarkList[i]['title'],
        description: bookmarkList[i]['description'],
        urlToImage: bookmarkList[i]['urlToImage'],
        publishedAt: DateTime.parse(bookmarkList[i]['publishedAt']),
        author: bookmarkList[i]['author'],
        content: bookmarkList[i]['content'],
      );
    });
  }

  Future<bool> isBookmarked(String title) async {
    final db = await database;
    final maps = await db.query('bookmarks', where: 'title = ?', whereArgs: [title]);
    return maps.isNotEmpty;
  }
}
