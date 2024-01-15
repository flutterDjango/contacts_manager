import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:contacts_manager/widgets/widgets.dart';

class CreateContactScreen extends StatelessWidget {
  static CreateContactScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const CreateContactScreen();
  const CreateContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DisplayWhiteTextWidget(
          text: 'Ajouter un contact',
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: const ContactFormWidget(),
    );
  }
}
