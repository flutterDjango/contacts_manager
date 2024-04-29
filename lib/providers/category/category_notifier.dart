import 'package:contacts_manager/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contacts_manager/providers/providers.dart';

class CategoryNotifier extends StateNotifier<CategoryState> {
  final CategoryRepository _repository;
  CategoryNotifier(this._repository) : super(const CategoryState.initial()) {
    getAllCategories();
  }

  Future<void> createCategory(Category category) async {
    try {
      await _repository.createCategory(category);
      getAllCategories();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Future<void> updateContact(Contact contact) async {
  //   try {
  //     await _repository.updateContact(contact);
  //     getAllContacts();
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // Future<void> deleteContact(Contact contact) async {
  //   try {
  //     await _repository.deleteContact(contact);
  //     getAllContacts();
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // Future<void> getCategoryById(int categoryId) async {
  //   try {
  //     final category = await _repository.getCategoryById(categoryId);
  //     state = state.copyWith(categories: category);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  Future<void> getAllCategories() async {
    try {
      final categories = await _repository.getAllCategories();
      state = state.copyWith(categories: categories);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
