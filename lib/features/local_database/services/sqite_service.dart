import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

/// Сервис, позволяющий получать базу данных билетов
class SQLiteService {
  static final SQLiteService db = SQLiteService();

  Database? _database;

  // get database
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "tickets_database.db");
    return await openDatabase(
      path,
      onCreate: (db, version) async {
        return await db.execute(
          'CREATE TABLE tickets '
          '(id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'name TEXT, '
          'pdfFileName TEXT,'
          'isLoaded INTEGER)',
        );
      },
      onOpen: (db) {},
      version: 1,
    );
  }
}
