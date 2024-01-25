import 'package:contacts_manager/utils/utils.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.contactItem,
    required this.labelText,
  });

  final TextEditingController controller;
  final Map<String, dynamic> contactItem;
  final String labelText;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    const Map<String, String> contactNameKey = {
      'Nom': 'contactLastName',
      'Prénom': 'contactFirstName'
    };
    return TextFormField(
        controller: widget.controller,
        maxLength: 15,
        decoration: InputDecoration(
          label: Text(widget.labelText),
        ),
        validator: (value) {
          return ValidFieldForm.validStringField(value, 15);
        },
        onSaved: (value) {
          final String nameKey = contactNameKey[widget.labelText]!;
          if (value != null && value.isNotEmpty) {
            widget.contactItem[nameKey] =
                value[0].toUpperCase() + value.substring(1).toLowerCase();
          } else {
            widget.contactItem[nameKey] = null;
          }
        });
  }
}
