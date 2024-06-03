import 'dart:ffi';
import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  // returns the instance of DatabaseHelper
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // reference to the database marked as private
  static Database? _database;

  // factory method that returns an instance of DatabaseHelper
  // to ensure that DatabaseHelper has only one instance in the application
  DatabaseHelper._privateConstructor();

  // get the database, if it is not initialized, initialize it first
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    // initialize the ffi loader to ensure that sqlite will work
    sqfliteFfiInit();

    // create path to store the database
    final io.Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbPath =
        p.join(appDirectory.path, 'databases', 'sudoku_database.db');

    final dbFactory = databaseFactoryFfi;
    // dbFactory.deleteDatabase(dbPath); //Debug
    // Open the database and return the reference
    return await dbFactory.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: _onCreate,
      ),
    );
  }

  Future<void> _onCreate(
    Database db,
    int version,
  ) async {
    // 'users' tábla létrehozása
    await db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY,
        username TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      )
    ''');

    // db.execute("DROP TABLE history");

    // 'history' tábla létrehozása
    await db.execute('''
      CREATE TABLE IF NOT EXISTS history (
        id INTEGER PRIMARY KEY,
        userid INTEGER NOT NULL,
        start_time TEXT NOT NULL,
        end_time TEXT NULL,
        is_finished INTEGER NOT NULL,
        difficulty TEXT NOT NULL
      )
    ''');
  }

  Future<int> createUser(
      {required String username, required String password}) async {
    Database db = await instance.database;

    return await db.insert(
      'users',
      <String, Object?>{
        'username': username,
        'password': password,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> createHistory(
      {required int userid,
      required String startTime,
      required String difficulty,
      required int isFinished}) async {
    Database db = await instance.database;

    int id = await db.insert(
      'history',
      <String, Object?>{
        'userid': userid,
        'start_time': startTime,
        'difficulty': difficulty,
        'is_finished': isFinished
      },
      // conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<Map<String, Object?>>> getHistory({
    required int userid,
  }) async {
    final db = await DatabaseHelper.instance.database;

    // query the database for the user
    return await db.query(
      'history',
      where: 'userid = ?',
      whereArgs: [userid],
    );
  }

  Future<List<Map<String, Object?>>> loginUser({
    required String username,
    required String password,
  }) async {
    final db = await DatabaseHelper.instance.database;

    // query the database for the user
    return await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [
        username,
        password,
      ],
    );
  }

  Future<int> checkUser({
    required String username,
  }) async {
    final db = await DatabaseHelper.instance.database;
    var result = await db
        .rawQuery('SELECT COUNT(*) FROM users WHERE username > ?', [username]);
    int count = result.first['COUNT(*)'] as int;
    return count;
  }
}
