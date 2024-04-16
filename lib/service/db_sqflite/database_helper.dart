// ignore_for_file: depend_on_referenced_packages, prefer_const_declarations

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:trendflix/service/model/sqflite_model.dart';

class DatabaseHelper {
  static Database? _database;
  static final _tableName = 'movies';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'movies.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
    CREATE TABLE $_tableName (
      id INTEGER PRIMARY KEY,
      name TEXT,
      posterPath TEXT,
      voteAverage REAL,
      date TEXT,
      backgroundPath TEXT,
      type TEXT
    )
  ''');
  }

  Future<int> insertMovie(SqfliteModel movie) async {
    final db = await database;
    return await db.insert(_tableName, movie.toMap());
  }

  Future<List<SqfliteModel>> getMoviesLocal() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return SqfliteModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        posterPath: maps[i]['posterPath'],
        voteAverage: maps[i]['voteAverage'],
        date: maps[i]['date'],
        backgroundPath: maps[i]['backgroundPath'],
        type: maps[i]['type'],
      );
    });
  }

  Future<int> deleteMovie(int id) async {
    final db = await database;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
