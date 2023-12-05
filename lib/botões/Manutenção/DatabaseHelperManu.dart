// Classe DatabaseHelperManu
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperManu {
  Future<Database> initializeDb() async {
    return openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT)",
        );
      },
      version: 1,
    );
  }
}
