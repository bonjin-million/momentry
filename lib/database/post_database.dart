import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:momentry/models/post/post.dart';

class PostDatabase {
  final _databaseName = 'momentry_database.db';
  final _databaseTableName = 'post';
  final _databaseVersion = 1;

  Database? _database;

  Future<Database> get database async {
    _database ??= await _init();
    return _database!;
  }

  Future<Database> _init() async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $_databaseTableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT,
            date TEXT
          )
        ''');
      },
      version: _databaseVersion,
    );
  }

  Future<List<Post>> findAll() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_databaseTableName);
    return maps.map((m) {
      return Post.fromJson(m);
    }).toList();
  }

  Future<void> insert(Map<String, dynamic> map) async {
    final db = await database;
    // late Post insertPost;
    // await db.transaction((txn) async {
    //   final id = await db.insert(
    //     _databaseTableName,
    //     post.toJson(),
    //     conflictAlgorithm: ConflictAlgorithm.replace,
    //   );
    //   final results = await txn.query(_databaseTableName, where: 'id = ?', whereArgs: [id]);
    //   insertPost = Post.fromJson(results.first);
    // });
    await db.insert(
      _databaseTableName,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(Post post) async {
    final db = await database;
    final id = post.id;
    await db.update(_databaseTableName, post.toMap(),
        where: 'id = ?', whereArgs: [id]);
  }

  Future<void> delete(int id) async {
    final db = await database;
    await db.delete(_databaseTableName, where: 'id = ?', whereArgs: [id]);
  }
}
