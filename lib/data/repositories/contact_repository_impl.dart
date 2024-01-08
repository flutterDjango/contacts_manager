import 'package:contacts_manager/data/data.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactDatabase _datasource;
  ContactRepositoryImpl(this._datasource);

  @override
  Future<void> createContact(Contact contact) async {
    try {
      await _datasource.addContact(contact);
    } catch (e) {
      throw '$e';
    }
  }

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
}
