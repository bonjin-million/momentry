import 'package:momentry/database/sql_database.dart';
import 'package:momentry/models/movie/movie_detail.dart';
import 'package:sqflite/sqflite.dart';

class MovieDatabase {
  Future<List<MovieDetail>> findAll() async {
    final db = await SqlDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'movie',
    );
    return maps.map((m) {
      return MovieDetail.fromJson(m);
    }).toList();
  }

  Future<MovieDetail> findById(int id) async {
    final db = await SqlDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'movie',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return MovieDetail.fromJson(maps.first);
  }

  Future<void> insert(Map<String, dynamic> map) async {
    final db = await SqlDatabase.instance.database;
    await db.insert(
      'movie',
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
