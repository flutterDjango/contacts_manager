import 'package:contacts_manager/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:contacts_manager/data/data.dart';
import 'package:contacts_manager/data/models/models.dart';
import 'package:contacts_manager/providers/contact/contact_provider.dart';
import 'package:contacts_manager/utils/utils.dart';
import 'package:contacts_manager/widgets/widgets.dart';

class ContactFormWidget extends ConsumerStatefulWidget {
  const ContactFormWidget({super.key});

  @override
  ConsumerState<ContactFormWidget> createState() => _ContactFormState();
}

class _ContactFormState extends ConsumerState<ContactFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _phoneNumber1Controller = TextEditingController();
  final TextEditingController _phoneNumber2Controller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? messageEmailAlreadyExist;
  String? messagePhone1AlreadyExist;
  String? messagePhone2AlreadyExist;

  String phoneCountryCode = "+33";
  bool phoneFieldOnFocus = false;
  bool emailFieldOnFocus = false;

  Map<String, dynamic> contactItem = {'contactCategoryId': 1};
  void getCountryCode(String countryCode) {
    setState(() {
      phoneCountryCode = countryCode;
    });
  }

  void getPhoneFieldOnFocusStatus(bool onFocus) {
    setState(() {
      phoneFieldOnFocus = onFocus;
    });
    if (phoneFieldOnFocus) {
      messagePhone1AlreadyExist = null;
      messagePhone2AlreadyExist = null;
    }
  }

  void getEmailFieldOnFocusStatus(bool onFocus) {
    setState(() {
      emailFieldOnFocus = onFocus;
    });
    if (emailFieldOnFocus) {
      messageEmailAlreadyExist = null;
    }
  }

  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    _phoneNumber1Controller.dispose();
    _phoneNumber2Controller.dispose();
    _emailController.dispose();
    super.dispose();
  }

  bool isPhoneValidated = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormFieldWidget(
                          controller: _lastNameController,
                          contactItem: contactItem,
                          labelText: 'Nom'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormFieldWidget(
                          controller: _firstNameController,
                          contactItem: contactItem,
                          labelText: 'Prénom'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PhoneFormFieldWidget(
                  controller: _phoneNumber1Controller,
                  contactItem: contactItem,
                  infoMessages: {
                    'labelText': 'Téléphone 1',
                    'messagePhoneAlreadyExist': messagePhone1AlreadyExist,
                  },
                  phoneCountryCode: (countryCode) =>
                      getCountryCode(countryCode),
                  phoneFieldOnFocus: (onFocus) =>
                      getPhoneFieldOnFocusStatus(onFocus),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PhoneFormFieldWidget(
                  controller: _phoneNumber2Controller,
                  contactItem: contactItem,
                  infoMessages: {
                    'labelText': 'Téléphone 2',
                    'messagePhoneAlreadyExist': messagePhone2AlreadyExist,
                  },
                  phoneCountryCode: (countryCode) =>
                      getCountryCode(countryCode),
                  phoneFieldOnFocus: (onFocus) =>
                      getPhoneFieldOnFocusStatus(onFocus),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: EmailFormFieldWidget(
                  controller: _emailController,
                  contactItem: contactItem,
                  messageEmailAlreadyExist: messageEmailAlreadyExist,
                  emailFieldOnFocus: (onFocus) =>
                      getEmailFieldOnFocusStatus(onFocus),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const DisplayWhiteTextWidget(
                          text: 'Annuler', fontSize: 20),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final form = _formKey.currentState!;
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        if (phoneFieldOnFocus) {
                          phoneFieldOnFocus = false;
                        }
                        if (emailFieldOnFocus) {
                          emailFieldOnFocus = false;
                        }
                        if (form.validate()) {
                          _checkIfTheContactCanBeReachead();

                          final List<Contact> allContacts =
                              ref.watch(contactProvider).contacts;
                          _checkIfEmailAlreadyExist(allContacts);
                          _checkIfPhoneAlreadyExist(allContacts);
                        }

                        if ([
                          messagePhone1AlreadyExist,
                          messagePhone2AlreadyExist,
                          messageEmailAlreadyExist
                        ].every((x) => x == null)) {
                          print('----------- save');
                          _saveContact();
                        } else {
                          print('----------- no save');
                        }

                        // _saveContact();
                      },
                      child: const DisplayWhiteTextWidget(
                          text: 'Ajouter', fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _checkIfTheContactCanBeReachead() async {
    bool anonymousContact = ValidFieldForm.lastNameAndFirstNameEmpty(
      lastName: _lastNameController.text.trim(),
      firstName: _firstNameController.text.trim(),
    );
    bool noWayToContact = ValidFieldForm.phonesAndEmailEmpty(
      phoneNumber1: _phoneNumber1Controller.text.trim(),
      phoneNumber2: _phoneNumber2Controller.text.trim(),
      email: _emailController.text.trim(),
    );

    if (anonymousContact) {
      await AppAlerts.showInformantionContactAlertDialog(
          context: context, message: 'Entrer un nom ou un prénom.');
    }
    if (!mounted) return;
    if (noWayToContact) {
      await AppAlerts.showInformantionContactAlertDialog(
          context: context,
          message: "Entrer au moins un numéro de téléphone ou l'email.");
    }
  }

  void _checkIfEmailAlreadyExist(List<Contact> allContacts) {
    final bool emailExist = ValidFieldForm.isEmailAlreadyExist(
      controller: _emailController,
      contacts: allContacts,
    );

    if (emailExist) {
      if (!emailFieldOnFocus) {
        setState(() {
          messageEmailAlreadyExist = "Cet email existe déjà.";
        });
      }
    } else {
      setState(() {
        messageEmailAlreadyExist = null;
      });
    }
  }

  void _checkIfPhoneAlreadyExist(List<Contact> allContacts) {
    const String messagePhoneNumber = "Ce numéro existe déjà";
    final bool phone1Exist = ValidFieldForm.isPhoneAlreadyExist(
      controller: _phoneNumber1Controller,
      phoneCountryCode: phoneCountryCode,
      contacts: allContacts,
    );
    final bool phone2Exist = ValidFieldForm.isPhoneAlreadyExist(
      controller: _phoneNumber2Controller,
      phoneCountryCode: phoneCountryCode,
      contacts: allContacts,
    );
    if (phone1Exist) {
      if (!phoneFieldOnFocus) {
        setState(() {
          messagePhone1AlreadyExist = messagePhoneNumber;
        });
      }
    } else if (phone2Exist) {
      if (!phoneFieldOnFocus) {
        setState(() {
          messagePhone2AlreadyExist = messagePhoneNumber;
        });
      }
    } else {
      setState(() {
        messagePhone1AlreadyExist = null;
        messagePhone2AlreadyExist = null;
      });
    }
  }

  void _saveContact() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final contact = Contact(
        contactId: 1,
        contactLastName: contactItem['contactLastName'],
        contactFirstName: contactItem['contactFirstName'],
        contactPhoneNumber1: contactItem['contactPhoneNumber1'],
        contactPhoneNumber2: contactItem['contactPhoneNumber2'],
        contactEmail: contactItem['contactEmail'],
        contactCategoryId: contactItem['contactCategoryId'],
      );
      print('contact $contact');

      // await ref
      //     .read(contactProvider.notifier)
      //     .createContact(contact)
      //     .then((value) => context.go(RouteLocation.home));
    }
  }
}
