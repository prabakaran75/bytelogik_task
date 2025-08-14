import 'package:bytelogik_task/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  final dbName = "auth.db";

  String user = '''
    CREATE TABLE users (
    userId INTEGER PRIMARY KEY AUTOINCREMENT,
    userName TEXT,
    email TEXT,
    password TEXT)
    ''';

  Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(user);
      },
    );
  }



  Future<UserModel?> getUser(String email) async {
    final Database db = await initDb();
    var res = await db.query("users", where: "email = ?", whereArgs: [email]);
    return res.isNotEmpty ? UserModel.fromMap(res.first) : null;
  }
}
