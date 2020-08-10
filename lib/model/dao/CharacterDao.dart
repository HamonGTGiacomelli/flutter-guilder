import 'package:guilderapp/model/CharacterModel.dart';
import 'package:guilderapp/model/dao/dbHelper.dart';
import 'package:sqflite/sqflite.dart';

class CharacterDao {
  static const String TABLE = "CHARACTERS";
  static const String COL_ID = "id";
  static const String COL_NAME = "name";
  static const String COL_GAME_SYSTEM = "gameSystem";
  static const String COL_CHARACTER_FUNCTION = "characterFunction";
  static const String COL_TABLE_ID = "tableId";

  DbHelper helper = DbHelper();

  Future<int> insert(CharacterModel character) async {
    Database db = await helper.db;
    var result =
        await db.insert(TABLE, character.toMap(), nullColumnHack: COL_ID);
    return result;
  }

  Future<int> update(CharacterModel character) async {
    Database db = await helper.db;
    var result = await db.update(TABLE, character.toMap(),
        where: "$COL_ID = ?", whereArgs: [character.id]);
    return result;
  }

  Future<int> delete(CharacterModel character) async {
    Database db = await helper.db;
    var result =
        await db.delete(TABLE, where: "$COL_ID = ?", whereArgs: [character.id]);
    return result;
  }

  Future<List<Map<String, dynamic>>> retrieveCharacters() async {
    Database db = await helper.db;
    var result = await db.query(TABLE);
    return result;
  }
}
