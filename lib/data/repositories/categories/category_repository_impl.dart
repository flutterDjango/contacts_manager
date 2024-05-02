import 'package:contacts_manager/data/data.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final ContactDatabase _datasource;
  CategoryRepositoryImpl(this._datasource);

  @override
  Future<void> createCategory(Category category) async {
    try {
      await _datasource.createCategory(category);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<void> deleteCategory(Category category) async {
    try {
      await _datasource.deleteCategory(category);
    } catch (e) {
      throw '$e';
    }
  }
  // @override
  // Future<Category> getCategoryById(int categoryId) async {
  //   try {
  //     return await _datasource.getCategoryById(categoryId);
  //   } catch (e) {
  //     throw '$e';
  //   }
  // }

  //  @override
  // Future<List<Category>> getCategoryById(int categoryId) async {
  //   try {
  //     return await _datasource.getCategoryById(categoryId);
  //   } catch (e) {
  //     throw '$e';
  //   }
  // }

  // @override
  // Future<void> updateContact(Contact contact) async {
  //   try {
  //     await _datasource.updateContact(contact);
  //   } catch (e) {
  //     throw '$e';
  //   }
  // }

  // @override
  // Future<void> deleteContact(Contact contact) async {
  //   try {
  //     await _datasource.deleteContact(contact);
  //   } catch (e) {
  //     throw '$e';
  //   }
  // }

  @override
  Future<List<Category>> getAllCategories() async {
    try {
      return await _datasource.getAllCategories();
    } catch (e) {
      throw '$e';
    }
  }
}
