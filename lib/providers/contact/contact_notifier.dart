import 'package:contacts_manager/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contacts_manager/providers/providers.dart';

class ContactNotifier extends StateNotifier<ContactState> {
  final ContactRepository _repository;
  ContactNotifier(this._repository) : super(const ContactState.initial()){
    getAllContacts();
  }

  Future<void> createContact(Contact contact) async {
    try {
      await _repository.createContact(contact);
      getAllContacts();
    } catch (e) {
      debugPrint(e.toString());
    }
  }


  Future<void> deleteContact(Contact contact) async {
    try {
      await _repository.deleteContact(contact);
      getAllContacts();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getAllContacts() async {
    try {
      final contacts = await _repository.getAllContacts();
      state = state.copyWith(contacts: contacts);
    } catch (e) {
      debugPrint(e.toString());
    }
  }


  // Future<void> deleteDatabase() async {
  //   try {
  //     await _repository.deleteDatabase();
  //     // getAllContacts();
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  
  // Future<void> databaseExists() async {
  //   try {
  //     await _repository.databaseExists();
  //     getAllContacts();
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

}
