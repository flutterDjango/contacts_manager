import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:contacts_manager/widgets/widgets.dart';
import 'package:contacts_manager/data/database/contact_database.dart';

class HomeScreen extends StatelessWidget {
  static HomeScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const HomeScreen();
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DisplayWhiteTextWidget(
          text: 'Liste des contacts',
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
        actions: [
          IconButton(
            onPressed: () {
            ContactDatabase().deleteDatabase();
            },
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.inversePrimary,
              size: 25,
            ),
            style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onPrimary),
          ),
        ],
      ),
      body: const Column(
        children: [
          HorizontalButtonBarWidget(),
          DisplayContactsListWidget(),
        ],
      ),
    );
  }
}


