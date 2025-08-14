import 'package:bytelogik_task/models/user_model.dart';
import 'package:bytelogik_task/sqlite_db/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class AuthService {
  final DbHelper dh = DbHelper();

  Future<bool> signIn(UserModel user) async {
    final Database db = await dh.initDb();
    var result = await db.rawQuery(
      "select * from users where email = ? AND password = ? ",
      [user.email, user.password],
    );
    //'${user.password}'- '${user.email}'
    if (result.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userEmail', user.email);
      return true;
    } else {
      return false;
    }
  }

  Future<int> signUp(UserModel user) async {
    final Database db = await dh.initDb();
    return db.insert("users", user.toMap());
  }

    Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
