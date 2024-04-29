import 'package:contacts_manager/data/repositories/categories/category_repository_provider.dart';
import 'package:contacts_manager/providers/category/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryProvider = StateNotifierProvider<CategoryNotifier, CategoryState>((ref) 
{
  final repository = ref.watch(categoryRepositoryProvider);
  return CategoryNotifier(repository);
});