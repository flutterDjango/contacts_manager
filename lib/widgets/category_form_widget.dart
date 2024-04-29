import 'package:contacts_manager/config/routes/routes_location.dart';
import 'package:contacts_manager/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:contacts_manager/utils/utils.dart';
import 'package:contacts_manager/widgets/widgets.dart';
import 'package:contacts_manager/data/models/models.dart';

class CategoryFormWidget extends ConsumerStatefulWidget {
  const CategoryFormWidget({super.key});

  @override
  ConsumerState<CategoryFormWidget> createState() => _CategoryFormWidgetState();
}

class _CategoryFormWidgetState extends ConsumerState<CategoryFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryNameController = TextEditingController();
  final Map<String, String?> categoryItem = {};
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: _categoryNameController,
                  maxLength: 15,
                  decoration: const InputDecoration(
                    label: Text('Catégorie'),
                  ),
                  validator: (value) {
                    return ValidFieldForm.validStringFieldNotEmpty(value, 15);
                  },
                  onSaved: (value) {
                    categoryItem['categoryName'] = value![0].toUpperCase() + value.substring(1).toLowerCase();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const DisplayWhiteTextWidget(
                          text: 'Annuler', fontSize: 20),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final form = _formKey.currentState!;
                        SystemChannels.textInput.invokeMethod('TextInput.hide');

                        if (form.validate()) {
                          _saveCategory();
                        }
                      },
                      child: const DisplayWhiteTextWidget(
                          text: 'Ajouter', fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveCategory() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    
      final category =
          Category(categoryName: categoryItem['categoryName'] ?? '');
      // print("** $category");
      await ref
          .read(categoryProvider.notifier)
          .createCategory(category)
          .then((value) => context.pop());
    }
  }
}
