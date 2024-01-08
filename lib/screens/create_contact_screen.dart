import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:contacts_manager/config/routes/routes_location.dart';
import 'package:contacts_manager/data/models/contact.dart';
import 'package:contacts_manager/widgets/widgets.dart';
import 'package:contacts_manager/providers/providers.dart';

class CreateContactScreen extends ConsumerStatefulWidget {
  static CreateContactScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const CreateContactScreen();
  const CreateContactScreen({super.key});

  @override
  ConsumerState<CreateContactScreen> createState() =>
      _CreateContactScreenState();
}

class _CreateContactScreenState extends ConsumerState<CreateContactScreen> {
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();

  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DisplayWhiteText(
          text: 'Ajouter un contact',
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Last Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'First Name'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createContact,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _createContact() async {
    final contact = Contact(
      contactLastName: _lastNameController.text.trim(),
      contactFirstName: _firstNameController.text.trim(),
      categoryId: 1,
    );

    await ref
        .read(contactProvider.notifier)
        .createContact(contact)
        .then((value) => context.go(RouteLocation.home));
  }
}
