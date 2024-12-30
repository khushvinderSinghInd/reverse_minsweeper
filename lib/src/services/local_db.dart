import 'dart:developer';

import 'package:sqflite/sqflite.dart';

class SqlDBService {
  SqlDBService._();
  static final SqlDBService sqlDBServiceinstance = SqlDBService._();
  static Database? _database;
  factory SqlDBService() => sqlDBServiceinstance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    return await openDatabase(
      'minesweeper_db',
      version: 20,
      onCreate: (Database database, int version) async {
        return await _createTables(database);
      },
    );
  }

  Future<void> _createTables(Database database) async {
    await database.execute("""CREATE TABLE UserData(
        uid TEXT,
        user_full_name TEXT,
        user_email TEXT,
        user_image TEXT
      )
      """);
  }

  Future wipeSqlData() async {
    Database database = SqlDBService._database!;
    try {
      await database.delete("UserData");
    } catch (e) {
      log("error message =>>> $e", name: "wipeSqlError");
    }
  }

  insertUser({
    required String uid,
    required String userFullName,
    required String userImage,
    required String userEmail,
  }) async {
    Database database = SqlDBService._database!;
    final data = {
      "uid": uid,
      "user_full_name": userFullName,
      "user_image": userImage,
      "user_email": userEmail,
    };
    return await database.insert(
      'UserData',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  getUserDetails() async {
    Database database = SqlDBService._database!;
    return await database.query(
      'UserData',
      orderBy: "uid",
    );
  }

  deleteUserDetails(uid) async {
    Database database = SqlDBService._database!;
    return await database.delete(
      'UserData',
      where: "uid = ?",
      whereArgs: [uid],
    );
  }
}
