import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDatabase {
  final _databaseName = 'momentry_database.db';
  final _databaseVersion = 1;
  static final SqlDatabase instance = SqlDatabase._instance();

  Database? _database;

  SqlDatabase._instance() {
    _init();
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    await _init();
    return _database!;
  }

  factory SqlDatabase() {
    return instance;
  }

  final _postTable = '''
            CREATE TABLE post(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT,
            imageFile TEXT,
            date TEXT
          )
        ''';

  final _bookTable = '''
                CREATE TABLE book(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT,
                content TEXT,
                image TEXT,
                publisher TEXT,
                author TEXT,
                star INTEGER,
                date TEXT
              )
        ''';

  Future<void> _init() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute(_postTable);
        await db.execute(_bookTable);
      },
    );
  }
}
