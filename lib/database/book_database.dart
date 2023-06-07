import 'package:momentry/database/sql_database.dart';
import 'package:momentry/models/book/book_detail.dart';
import 'package:sqflite/sqflite.dart';

class BookDatabase {
  Future<List<BookDetail>> findAll() async {
    final db = await SqlDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'book',
    );
    return maps.map((m) {
      return BookDetail.fromJson(m);
    }).toList();
  }

  Future<BookDetail> findById(int id) async {
    final db = await SqlDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'book',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return BookDetail.fromJson(maps.first);
  }

  Future<void> insert(Map<String, dynamic> map) async {
    final db = await SqlDatabase.instance.database;
    await db.insert(
      'book',
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
