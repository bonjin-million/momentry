import 'package:momentry/database/sql_database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:momentry/models/post/post.dart';

class PostDatabase {
  Future<List<Post>> findAll() async {
    final db = await SqlDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('post');
    return maps.map((m) {
      return Post.fromJson(m);
    }).toList();
  }

  Future<Post> findById(int id) async {
    final db = await SqlDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'post',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return Post.fromJson(maps.first);
  }

  Future<void> insert(Map<String, dynamic> map) async {
    final db = await SqlDatabase.instance.database;
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
      'post',
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(Post post) async {
    final db = await SqlDatabase.instance.database;
    final id = post.id;
    await db.update('post', post.toMap(), where: 'id = ?', whereArgs: [id]);
  }

  Future<void> delete(int id) async {
    final db = await SqlDatabase.instance.database;
    await db.delete('post', where: 'id = ?', whereArgs: [id]);
  }
}
