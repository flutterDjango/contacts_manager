import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:contacts_manager/utils/utils.dart';
import 'package:contacts_manager/data/data.dart';

class ContactDatabase {
  final dbInit = DatabaseManager().databaseInit;

  Future<int> addContact(Contact contact) async {
    final db = await dbInit;
    return db.transaction(
      (txn) async {
        return await txn.insert(
          DbKeys.dbContactTable,
          contact.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      },
    );
  }

  Future<int> updateContact(Contact contact) async {
    final db = await dbInit;
    return db.transaction(
      (txn) async {
        return await txn.update(
          DbKeys.dbContactTable,
          contact.toJson(),
          where: 'contactId = ?',
          whereArgs: [contact.contactId],
        );
      },
    );
  }

  Future<int> deleteContact(Contact contact) async {
    final db = await dbInit;
    return db.transaction(
      (txn) async {
        return await txn.delete(
          DbKeys.dbContactTable,
          where: 'contactId = ?',
          whereArgs: [contact.contactId],
        );
      },
    );
  }


  Future<List<Contact>> getAllContacts() async {
    
    final db = await dbInit;
    final List<Map<String, dynamic>> data = await db.query(
      DbKeys.dbContactTable,
      orderBy: "CONTACTID DESC",
    );
    return List.generate(
      data.length,
      (index) => Contact.fromJson(data[index]),
    );
  }

  Future<List<Contact>> searchContacts(String keyboard) async {
    final db = await dbInit;
    if (keyboard.isNotEmpty) {
      final List<Map<String, dynamic>> data = await db.query(
        DbKeys.dbContactTable,
        where: "(contactLastName LIKE '%$keyboard%') OR (contactFirstName LIKE '%$keyboard%')",
      );
      // print('data sql :::: $data');
      return List.generate(
        data.length,
        (index) => Contact.fromJson(data[index]),
      );
    } else {
      print('liste vide');
      return [];
    }
  }

  Future<void> deleteDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DbKeys.dbName);
    databaseFactory.deleteDatabase(path);
  }

 
}
