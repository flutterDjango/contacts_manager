import 'package:contacts_manager/data/data.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactDatabase _datasource;
  ContactRepositoryImpl(this._datasource);

  @override
  Future<void> createContact(Contact contact) async {
    try {
      await _datasource.createContact(contact);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<void> updateContact(Contact contact) async {
    try {
      await _datasource.updateContact(contact);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<void> deleteContact(Contact contact) async {
    try {
      await _datasource.deleteContact(contact);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<List<Contact>> getAllContacts() async {
    try {
      return await _datasource.getAllContacts();
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<List<Contact>> searchContacts(String keyboard) async {
    try {
      return await _datasource.searchContacts(keyboard);
    } catch (e) {
      throw '$e';
    }
  }
}
