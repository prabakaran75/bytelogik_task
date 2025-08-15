import 'package:shared_preferences/shared_preferences.dart';
import 'package:bytelogik_task/models/user_model.dart';
import 'package:bytelogik_task/sqlite_db/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class AuthService {
  final DbHelper dh = DbHelper();

  Future<String> signIn(UserModel user) async {
    final Database db = await dh.initDb();

    var existingUser = await db.query(
      "users",
      where: "email = ?",
      whereArgs: [user.email],
    );

    if (existingUser.isEmpty) {
      return "no_user";
    }

    var result = await db.query(
      "users",
      where: "email = ? AND password = ?",
      whereArgs: [user.email, user.password],
    );

    if (result.isEmpty) {
      return "wrong_password";
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', user.email);

    return "success";
  }


  Future<String> signUp(UserModel user) async {
    final Database db = await dh.initDb();
    final existingUser = await db.query(
      "users",
      where: "email = ?",
      whereArgs: [user.email],
    );
    if (existingUser.isNotEmpty) {
      // Return custom message
      return "exists";
    }

    await db.insert("users", user.toMap());
    return "success";
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
