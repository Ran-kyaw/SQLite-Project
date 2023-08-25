import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConneection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_crud');
    var database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);

    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    String sql =
        " CREATE TABLE notes (id INTEGER PRIMARY KEY,title TEXT, imagePath TEXT, description TEXT, createDate TEXT);";

    await database.execute(sql);
  }
}
