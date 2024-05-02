import 'package:contacts_manager/data/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:contacts_manager/widgets/widgets.dart';

class CreateContactScreen extends StatelessWidget {
  static CreateContactScreen builder(
    BuildContext context,
    GoRouterState state,
  ) { 
      final obj = state.extra as Contact?;
      if (obj != null) return CreateContactScreen(contact: obj);
      return const CreateContactScreen();
    }

  const CreateContactScreen({super.key, this.contact});
  final Contact? contact; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DisplayWhiteTextWidget(
          text: (contact == null) ? 'Ajouter un contact.' :'Modifier un contact.',
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: ContactFormWidget(contact: contact),
    );
  }
}
