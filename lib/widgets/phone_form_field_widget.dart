import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

typedef StringCountryCodeCallback = void Function(String countryCode);
typedef BoolOnFocusPhoneCallback = void Function(bool onFocus);

class PhoneFormFieldWidget extends StatefulWidget {
  const PhoneFormFieldWidget({
    super.key,
    required this.controller,
    required this.contactItem,
    required this.infoMessages,
    required this.phoneCountryCode,
    required this.phoneFieldOnFocus,
  });

  final TextEditingController controller;
  final Map<String, dynamic> contactItem;

  final StringCountryCodeCallback phoneCountryCode;
  final BoolOnFocusPhoneCallback phoneFieldOnFocus;
  final Map<String, String?> infoMessages;

  @override
  State<PhoneFormFieldWidget> createState() => _PhoneFormFieldWidgetState();
}

class _PhoneFormFieldWidgetState extends State<PhoneFormFieldWidget> {
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        widget.controller.clearComposing();
        widget.phoneFieldOnFocus(true);
      } else {
        widget.phoneFieldOnFocus(false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const Map<String, String> phoneKeyName = {
      'Téléphone 1': 'contactPhoneNumber1',
      'Téléphone 2': 'contactPhoneNumber2'
    };
    final String? labelText = widget.infoMessages['labelText'];
    final String? messagePhoneAlreadyExist =
        widget.infoMessages['messagePhoneAlreadyExist'];

    return IntlPhoneField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: messagePhoneAlreadyExist,
        errorStyle: const TextStyle(color: Colors.red),
        border: const OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
      initialCountryCode: 'FR',
      focusNode: _focusNode,
      invalidNumberMessage: 'Numéro invalide',
      controller: widget.controller,
      onChanged: (phone) {
        widget.phoneCountryCode(phone.countryCode);
        widget.phoneFieldOnFocus(true);
      },
      validator: (phone) {
        if (phone != null && phone.number.isNotEmpty) {
          return 'Entrer uniquement des chiffres.';
        }
        return null;
      },
      onSaved: (phone) {
        final String phoneKey = phoneKeyName[labelText]!;
        if (phone != null) {
          print('phoneKey $phoneKey');
          print('phoneKey ${phone.number}');
          print('phoneKey ${phone.number.isEmpty}');

          (phone.number.isEmpty)
              ? widget.contactItem[phoneKey] = '125'
              : widget.contactItem[phoneKey] = phone.completeNumber;
        }
      },
    );
  }
}
