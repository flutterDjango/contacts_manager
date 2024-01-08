import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:contacts_manager/utils/utils.dart';

class DatabaseManager {
  static final DatabaseManager _instance = DatabaseManager._();
  factory DatabaseManager() => _instance;

  DatabaseManager._() {
    _initDb();
  }

  static Database? database;

  Future<Database> get databaseInit async {
    database ??= await _initDb();
    return database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DbKeys.dbName);
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE ${DbKeys.dbContactTable} (
      contactId INTEGER PRIMARY KEY AUTOINCREMENT,
      contactLastName TEXT,
      contactFirstName TEXT,
      categoryId INT NOT NULL,
      FOREIGN KEY (categoryId) REFERENCES category (categoryId) 
      )
    ''');

    await db.execute('''
          CREATE TABLE ${DbKeys.dbCategoryTable} (
            categoryId INTEGER PRIMARY KEY AUTOINCREMENT,
            categoryName TEXT
          )
          ''');
  }

  Future<void> deleteDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DbKeys.dbName);
    databaseFactory.deleteDatabase(path);
  }
}
