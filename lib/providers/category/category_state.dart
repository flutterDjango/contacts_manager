import 'package:contacts_manager/data/models/models.dart';
import 'package:equatable/equatable.dart';


class CategoryState extends Equatable {
  const CategoryState(this.categories);
  
  const CategoryState.initial({this.categories= const []});
  final List<Category> categories;
  // final Category category;


  CategoryState copyWith({
    List<Category>? categories,
  }) {
    return CategoryState(categories ?? this.categories);
  }


  // CategoryState copyWith({
  //   Category? category,
  // }) {
  //   return CategoryState(category ?? this.category);
  // }
  @override
  List<Object> get props => [categories];

}