import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart' as web;
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;

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
    if (kIsWeb) {
      final dbFactory = web.databaseFactoryFfiWeb;
      return dbFactory.openDatabase(
        dbName,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (db, version) async {
            await db.execute(user);
          },
        ),
      );
    }

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqflite_ffi.sqfliteFfiInit();
      final dbFactory = sqflite_ffi.databaseFactoryFfi;
      final dbPath = await sqflite.getDatabasesPath();
      final path = join(dbPath, dbName);
      return dbFactory.openDatabase(
        path,
        options: sqflite_ffi.OpenDatabaseOptions(
          version: 1,
          onCreate: (db, version) async {
            await db.execute(user);
          },
        ),
      );
    }

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return sqflite.openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(user);
      },
    );
  }
}
