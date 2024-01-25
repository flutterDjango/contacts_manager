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
      contactPhoneNumber1 TEXT,
      countryCode1 TEXT,
      completePhoneNumber1 TEXT,
      contactPhoneNumber2 TEXT,
      countryCode2 TEXT,
      completePhoneNumber2 TEXT,
      contactEmail TEXT,
      contactCategoryId INT NOT NULL,
      FOREIGN KEY (contactCategoryId) REFERENCES category (categoryId) 
      )
    ''');

    await db.execute('''
          CREATE TABLE ${DbKeys.dbCategoryTable} (
            categoryId INTEGER PRIMARY KEY AUTOINCREMENT,
            categoryName TEXT
          )
          ''');
  }

  // Future<int?> tableIsEmpty() async {
  //   final db = await _initDb();
  //   return Sqflite.firstIntValue(
  //       await db.rawQuery('SELECT COUNT(*) FROM ${DbKeys.dbContactTable}'));

  //   // return databaseFactory.databaseExists(path);
  // }
}
