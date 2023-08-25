
import 'package:sqflite/sqflite.dart';

import 'db_connection.dart';

class Repository {
  late DatabaseConneection _databaseConneection;
  Repository() {
    _databaseConneection = DatabaseConneection();
  }
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConneection.setDatabase();
      return _database;
    }
  }

  // Insert Note
  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  // Read All Note
  readData(table) async {
    var connection = await database;
    return await connection?.query(table,orderBy:"id DESC");
  }

  //Read a Single Record By ID
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  //Update Note
  updateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //Delete Note
  deleteDataById(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$itemId");
  }
}