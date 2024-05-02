import 'package:contacts_manager/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:contacts_manager/data/models/models.dart';
import 'package:contacts_manager/utils/utils.dart';
import 'package:contacts_manager/providers/providers.dart';

class AppAlerts {
  AppAlerts._();

  static displaySnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: context.textTheme.bodyLarge
              ?.copyWith(color: context.colorScheme.surface),
        ),
        backgroundColor: context.colorScheme.primary,
      ),
    );
  }

  static Future<void> showDeleteContactAlertDialog(
    BuildContext context,
    WidgetRef ref,
    Contact contact,
  ) async {
    Widget cancelButton = TextButton(
      onPressed: () => context.pop(),
      child: const Text('NON'),
    );
    Widget deleteButton = TextButton(
      onPressed: () async {
        await ref.read(contactProvider.notifier).deleteContact(contact).then(
          (value) {
            AppAlerts.displaySnackBar(context, "Le contact est effacé.");
            context.pop();
          },
        );
      },
      child: const Text('OUI'),
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Etes-vous sûr de vouloir supprimer ce contact ?"),
      actions: [
        deleteButton,
        cancelButton,
      ],
    );
    await showDialog(
      context: context,
      builder: (ctx) {
        return alert;
      },
    );
  }

  static Future<void> showDeleteCategoryAlertDialog(
    BuildContext context,
    WidgetRef ref,
    Category category,
  ) async {
    Widget cancelButton = TextButton(
      onPressed: () => context.pop(),
      child: const Text('NON'),
    );
    Widget deleteButton = TextButton(
      onPressed: () async {
        await ref.read(categoryProvider.notifier).deleteCategory(category).then(
          (value) {
            AppAlerts.displaySnackBar(context, "La categorie est effacée.");
            context.pop();
          },
        );
      },
      child: const Text('OUI'),
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Etes-vous sûr de vouloir supprimer cette categorie ?"),
      actions: [
        deleteButton,
        cancelButton,
      ],
    );
    await showDialog(
      context: context,
      builder: (ctx) {
        return alert;
      },
    );
  }

static Future<void> showDeleteDatabaseAlertDialog(
    BuildContext context,
  ) async {
    Widget cancelButton = TextButton(
      onPressed: () => context.pop(),
      child: const Text('NON'),
    );
    Widget deleteButton = TextButton(
      onPressed: () {
        debugPrint('cancel');
        ContactDatabase().deleteDatabase();
        AppAlerts.displaySnackBar(context, "La base est effacée.");
        context.pop();
      },
      child: const Text('OUI'),
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Etes-vous sûr de vouloir supprimer la base de donnée ?"),
      actions: [
        deleteButton,
        cancelButton,
      ],
    );
    await showDialog(
      context: context,
      builder: (ctx) {
        return alert;
      },
    );
  }
  static Future<void> showInformantionContactAlertDialog({
    BuildContext? context,
    String? message,
  }) async {
    Widget okButton = TextButton(
      onPressed: () => context!.pop(),
      child: const Text('OK'),
    );

    AlertDialog alert = AlertDialog(
      title: Text(message!),
      actions: [
        okButton,
      ],
    );
    await showDialog(
      context: context!,
      builder: (ctx) {
        return alert;
      },
    );
  }
}
