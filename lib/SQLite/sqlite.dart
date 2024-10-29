import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tech_shop_app2/JsonModels/users.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, 'tech_shop.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      usrEmail TEXT NOT NULL UNIQUE,  -- Ensure the email is unique
      usrPassword TEXT NOT NULL
    )
    ''');
  }

  // Sign up method
  Future<void> signUp(Users user) async {
    final db = await database;

    var result = await db.query(
      'users',
      where: 'usrEmail = ?',
      whereArgs: [user.usrEmail],
    );

    if (result.isNotEmpty) {
      throw Exception('Email already in use');
    } else {
      // Insert new user
      await db.insert('users', user.toMap());
    }
  }

  // Login method
  Future<bool> login(Users user) async {
    final db = await database;

    // Query to find a user with matching email and password
    var res = await db.query(
      'users',
      where: 'usrEmail = ? AND usrPassword = ?',
      whereArgs: [user.usrEmail, user.usrPassword],
    );

    // If a match is found, login is successful
    return res.isNotEmpty;
  }
}
