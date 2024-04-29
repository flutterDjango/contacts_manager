import 'package:contacts_manager/data/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:contacts_manager/widgets/widgets.dart';

class CategoryScreen extends StatelessWidget {
  static CategoryScreen builder(
    BuildContext context,
    GoRouterState state,
  ) => const CategoryScreen();
  
  const CategoryScreen({super.key, this.category});
  final Contact? category; 
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const DisplayWhiteTextWidget(
          text: 'Catégories',
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: const DisplayCategoriesListWidget(),
    );
  }
}