import 'package:know_more/Models/Articles.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dbhelper {
  static final _databasename = "knowmore.db";
  static final _databaseversion = 1;

  // the table name
  static final _articletable = "article_table";

  // column names for articletable
  String _author = 'author';
  String _desc = 'desc';
  String _title = 'title';
  String _urlToImage = 'urlToImage';
  String _publishedAt = 'publishedAt';
  String _url = 'url';
  String _id = 'id';

  Database? _database;

  // CREATE DATABSE
  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), _databasename),
          version: _databaseversion,
          onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE $_articletable($_id INTEGER PRIMARY KEY autoincrement, $_author TEXT,$_desc TEXT, $_title TEXT, $_urlToImage TEXT, $_publishedAt  TEXT,$_url  TEXT);');
      });
    }
  }

  // INSERT ARTICLES
  Future<int> insertArticle(Article article) async {
    int taskId = 0;
    await openDb();
    print(article);
    await _database!
        .insert(_articletable, article.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      print(value);
      taskId = value;
    });
    return taskId;
  }

  // GET ARTICLES
  Future<List<Article>> queryAll() async {
    await openDb();
    List<Map<String, dynamic>> articleMap =
        await _database!.query(_articletable);
    return List.generate(articleMap.length, (index) {
      return Article(
          title: articleMap[index]['title'],
          desc: articleMap[index]['desc'],
          author: articleMap[index]['author'],
          publishedAt: articleMap[index]['publishedAt'],
          url: articleMap[index]['url'],
          urlToImage: articleMap[index]['urlToImage'],
          id: articleMap[index]['id']);
    });
  }

  Future<List<Article>> queryOnly(String query) async {
    await openDb();
    List<Map<String, dynamic>> articleMap = await _database!
        .rawQuery("SELECT * FROM $_articletable WHERE $_title LIKE '$query%'");
    return List.generate(articleMap.length, (index) {
      return Article(
          title: articleMap[index]['title'],
          desc: articleMap[index]['desc'],
          author: articleMap[index]['author'],
          publishedAt: articleMap[index]['publishedAt'],
          url: articleMap[index]['url'],
          urlToImage: articleMap[index]['urlToImage'],
          id: articleMap[index]['id']);
    });
  }

  // DELETE ARTICLES
  Future<void> deleteTask(int id) async {
    await openDb();
    await _database!.rawDelete("DELETE FROM $_articletable WHERE id = '$id'");
  }
}
