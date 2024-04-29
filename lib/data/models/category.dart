import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int? categoryId;
  final String categoryName;

  const Category({
    this.categoryId,
    required this.categoryName,
  });

  @override
  List<Object> get props {
    return [
      categoryId!,
      categoryName,
    ];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'categoryId': categoryId,
      'categoryName': categoryName,
    };
  }

  factory Category.fromJson(Map<String, dynamic> map) {
    return Category(
      categoryId: map['categoryId'],
      categoryName: map['categoryName'],
    );
  }


  Category copyWith({
    int? categoryId,
    String? categoryName,
    
  }) {
    return Category(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
     
    );
  }
}
