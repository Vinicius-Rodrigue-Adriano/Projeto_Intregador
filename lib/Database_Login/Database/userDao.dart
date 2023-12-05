
import 'package:projeto_intregador/Database_Login/models/usermodel.dart';
import 'package:projeto_intregador/Database_Login/Database/DatabaseHelper.dart';

class UserDao {
  final dbProvider = DatabaseHelper.instance;

  Future<int> createUser(UserModel user) async {
    final db = await dbProvider.database;
    var result = db.insert('users', user.toMap());
    return result;
  }

  Future<List<UserModel>> getUsers() async {
    final db = await dbProvider.database;
    List<Map> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      return UserModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        email: maps[i]['email'],
        password: maps[i]['password'],
      );
    });
  }

  // Adicione o método updateUser
  Future<int> updateUser(UserModel user) async {
    final db = await dbProvider.database;
    return db.update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }
}
