import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

typedef BoolOnFocusEmailCallback = void Function(bool onFocus);

class EmailFormFieldWidget extends StatefulWidget {
  const EmailFormFieldWidget(
      {super.key,
      required this.controller,
      required this.contactItem,
      required this.emailFieldOnFocus,
      this.messageEmailAlreadyExist});

  final TextEditingController controller;
  final Map<String, dynamic> contactItem;
  final String? messageEmailAlreadyExist;
  final BoolOnFocusEmailCallback emailFieldOnFocus;

  @override
  State<EmailFormFieldWidget> createState() => _EmailFormFieldWidgetState();
}

class _EmailFormFieldWidgetState extends State<EmailFormFieldWidget> {
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        widget.controller.clearComposing();
        widget.emailFieldOnFocus(true);
      } else {
        widget.emailFieldOnFocus(false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: 'Email',
        prefixIcon: const Icon(Icons.mail),
        errorText: widget.messageEmailAlreadyExist,
        errorStyle: const TextStyle(color: Colors.red),
      ),
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      onChanged: (email) {
        widget.emailFieldOnFocus(true);
      },
      validator: (email) {
        if (email == null || email.isEmpty) {
          return null;
        } else {
          return !EmailValidator.validate(email)
              ? 'Entrer un email valide.'
              : null;
        }
      },
      onSaved: (email) {
        widget.contactItem['contactEmail'] = email;
      },
    );
  }
}
