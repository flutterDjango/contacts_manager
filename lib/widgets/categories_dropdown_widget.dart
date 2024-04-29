import 'package:flutter/material.dart';
import 'package:contacts_manager/data/models/models.dart';

class CategoriesDropdownWidget extends StatefulWidget {
  const CategoriesDropdownWidget({
    super.key,
    required this.categories,
    required this.initialCategory,
    required this.selectedCategory,
  });

  final List<Category>? categories;
  final Function(Category) selectedCategory;
  final String? initialCategory;

  @override
  State<CategoriesDropdownWidget> createState() =>
      _CategoriesDropdownWidgetState();
}

class _CategoriesDropdownWidgetState extends State<CategoriesDropdownWidget> {
  Category? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Category>(
      hint: (widget.initialCategory == null)
          ? const Text('Selectionner une categorie')
          : Text(widget.initialCategory!),
      value: selectedCategory,
      items: widget.categories!
          .map(
            (category) => DropdownMenuItem(
                value: category, child: Text(category.categoryName)),
          )
          .toList(),
      
      onChanged: (category) => setState(
        () {
          selectedCategory = category;
          widget.selectedCategory(selectedCategory!);
        },
      ),
    );
  }
}
