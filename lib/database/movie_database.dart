import 'package:momentry/database/sql_database.dart';
import 'package:momentry/models/movie/movie_detail.dart';
import 'package:sqflite/sqflite.dart';

class MovieDatabase {
  final _tableName = 'movie';
  Future<List<MovieDetail>> findAll() async {
    final db = await SqlDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
    );
    return maps.map((m) {
      return MovieDetail.fromJson(m);
    }).toList();
  }

  Future<MovieDetail> findById(int id) async {
    final db = await SqlDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return MovieDetail.fromJson(maps.first);
  }

  Future<void> insert(Map<String, dynamic> map) async {
    final db = await SqlDatabase.instance.database;
    await db.insert(
      _tableName,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(Map<String, dynamic> map, int id) async {
    final db = await SqlDatabase.instance.database;
    await db.update(_tableName, map, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> delete(int id) async {
    final db = await SqlDatabase.instance.database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
