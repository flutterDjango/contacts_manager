import 'package:contacts_manager/data/models/models.dart';

abstract class CategoryRepository {
  Future<void> createCategory(Category category);
  // Future<void> updateCategory(Category category);

  Future<void> deleteCategory(Category category);
  Future<List<Category>> getAllCategories();
  // Future<List<Category>> getCategoryById(int categoryId);
 
}