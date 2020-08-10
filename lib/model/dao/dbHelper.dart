import 'dart:io';

import 'package:guilderapp/model/dao/CharacterDao.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  final String DB_NAME = "guilder.db";
  final int DB_VERSION = 1;

  DbHelper._internal();

  static final DbHelper _dbHelper = DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  Future<Database> initializeDb() async {
    String path = await getDatabasesPath();
    var dbGuilder = await openDatabase(join(path, DB_NAME),
        version: DB_VERSION, onCreate: _createDatabase);
    return dbGuilder;
  }

  void _createDatabase(Database db, int version) async {
    await db.execute("CREATE TABLE ${CharacterDao.TABLE} ("
        "${CharacterDao.COL_ID} INTEGER PRIMARY KEY,"
        "${CharacterDao.COL_NAME} TEXT,"
        "${CharacterDao.COL_CHARACTER_FUNCTION} TEXT,"
        "${CharacterDao.COL_GAME_SYSTEM} TEXT,"
        "${CharacterDao.COL_TABLE_ID} INTEGER"
        ")");
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }
}
