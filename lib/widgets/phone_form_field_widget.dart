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
    const Map<String, List<String>> phoneKeyName = {
      'Téléphone 1': [
        'countryCode1',
        'contactPhoneNumber1',
        'completePhoneNumber1'
      ],
      'Téléphone 2': [
        'countryCode2',
        'contactPhoneNumber2',
        'completePhoneNumber2'
      ]
    };

    final String? labelText = widget.infoMessages['labelText'];
    final String? messagePhoneAlreadyExist =
        widget.infoMessages['messagePhoneAlreadyExist'];

    final String completeNumberKey = phoneKeyName[labelText]![2];
    final String phoneNumberKey = phoneKeyName[labelText]![1];
    final String countryCodeKey = phoneKeyName[labelText]![0];

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
      initialCountryCode: _countryIsoCode(widget.contactItem, countryCodeKey),
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
        if (phone != null) {
          widget.contactItem[countryCodeKey] =
              '${phone.countryISOCode}-${phone.countryCode}';
          if (phone.number.isEmpty) {
            widget.contactItem[phoneNumberKey] = null;
            widget.contactItem[completeNumberKey] = null;
          } else {
            widget.contactItem[phoneNumberKey] = phone.number;
            widget.contactItem[completeNumberKey] = phone.completeNumber;
          }
        }
      },
    );
  }

  String _countryIsoCode(contactItem, countryCodeKey) {
    final String? countryCode = contactItem[countryCodeKey];
    if (countryCode != null && countryCode.isNotEmpty) {
      return countryCode.split('-').first;
    }
    return 'FR';
  }
}
