import 'package:contacts_manager/data/models/models.dart';

abstract class ContactRepository {
  Future<void> createContact(Contact contact);
  Future<void> deleteContact(Contact contact);
  Future<List<Contact>> getAllContacts();
}