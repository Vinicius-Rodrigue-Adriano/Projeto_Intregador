import 'package:sqflite/sqflite.dart';
import 'package:projeto_intregador/bot%C3%B5es/Manuten%C3%A7%C3%A3o/DatabaseHelperManu.dart';
import 'package:projeto_intregador/bot%C3%B5es/Manuten%C3%A7%C3%A3o/UserModelManu.dart';

class UserDaoManu {
  late Future<Database> database;
  DatabaseHelperManu dbHelper = DatabaseHelperManu();

  UserDaoManu() {
    database = dbHelper.initializeDb();
  }

  Future<void> insertUser(UserModelManu user) async {
    final db = await database;

    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<UserModelManu>> users() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      return UserModelManu(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }
}
