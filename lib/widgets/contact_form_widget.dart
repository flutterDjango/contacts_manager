import 'package:contacts_manager/config/routes/routes_location.dart';
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
  const ContactFormWidget({super.key, this.contact});

  final Contact? contact;
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

  Map<String, String> phoneCountryCode = {};
  bool phoneFieldOnFocus = false;
  bool emailFieldOnFocus = false;

  Map<String, dynamic> contactItem = {'contactCategoryId': 1};

  void getCountryCode(String countryCode, String countryCodeKey) {
    setState(() {
      phoneCountryCode[countryCodeKey] = countryCode;
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

  @override
  void initState() {
    if (widget.contact != null) {
      contactItem["contactId"] = widget.contact!.contactId;
      _lastNameController.text = widget.contact!.contactLastName ?? '';
      _firstNameController.text = widget.contact!.contactFirstName ?? '';
      contactItem["countryCode1"] = widget.contact!.countryCode1;
      contactItem["countryCode2"] = widget.contact!.countryCode2;

      phoneCountryCode["countryCode1"] =
          widget.contact!.countryCode1.split('-').last;
      phoneCountryCode["countryCode2"] =
          widget.contact!.countryCode1.split('-').last;

      _phoneNumber1Controller.text = widget.contact!.contactPhoneNumber1 ?? '';
      _phoneNumber2Controller.text = widget.contact!.contactPhoneNumber2 ?? '';
      _emailController.text = widget.contact!.contactEmail ?? '';
    }
    super.initState();
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
                      getCountryCode(countryCode, "countryCode1"),
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
                      getCountryCode(countryCode, "countryCode2"),
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
                      onPressed: () async {
                        final form = _formKey.currentState!;
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        if (phoneFieldOnFocus) {
                          phoneFieldOnFocus = false;
                        }
                        if (emailFieldOnFocus) {
                          emailFieldOnFocus = false;
                        }
                        if (form.validate()) {
                          final controllers = {
                            'phoneNumber1Controller': _phoneNumber1Controller,
                            'phoneNumber2Controller': _phoneNumber2Controller,
                            'lastNameController': _lastNameController,
                            'firstNameController': _firstNameController,
                            'emailController': _emailController,
                          };

                          final List<Contact> allContacts =
                              ref.watch(contactProvider).contacts;

                          final phoneAlreadyExist =
                              ValidFieldForm.checkIfPhoneAlreadyExist(
                            allContacts,
                            widget.contact,
                            controllers,
                            phoneCountryCode,
                            phoneFieldOnFocus,
                          );
                          final emailAlreadyExist =
                              ValidFieldForm.checkIfEmailAlreadyExist(
                            allContacts,
                            widget.contact,
                            _emailController,
                            emailFieldOnFocus,
                          );

                          setState(() {
                            messagePhone1AlreadyExist =
                                phoneAlreadyExist['phoneExist1'];
                            messagePhone2AlreadyExist =
                                phoneAlreadyExist['phoneExist2'];
                            messageEmailAlreadyExist = emailAlreadyExist;
                          });

                          if ([
                            messagePhone1AlreadyExist,
                            messagePhone2AlreadyExist,
                            messageEmailAlreadyExist
                          ].every((x) => x == null)) {
                            bool contactCanBeReachead = await ValidFieldForm
                                .checkIfTheContactCanBeReachead(
                                    controllers, context);
                            if (!mounted) return;
                            bool identicalPhone = await ValidFieldForm
                                .checkIfPhoneNumbersAreTheSame(
                                    controllers, phoneCountryCode, context);
                            if (contactCanBeReachead && !identicalPhone) {
                              (widget.contact == null)
                                  ? _saveContact()
                                  : _updateContact();
                            }
                          }
                        }
                      },
                      child: DisplayWhiteTextWidget(
                          text:
                              (widget.contact == null) ? 'Ajouter' : 'Modifier',
                          fontSize: 20),
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

  void _saveContact() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final contact = Contact(
        contactLastName: contactItem['contactLastName'],
        contactFirstName: contactItem['contactFirstName'],
        contactPhoneNumber1: contactItem['contactPhoneNumber1'],
        countryCode1: contactItem['countryCode1'],
        completePhoneNumber1: contactItem['completePhoneNumber1'],
        contactPhoneNumber2: contactItem['contactPhoneNumber2'],
        countryCode2: contactItem['countryCode2'],
        completePhoneNumber2: contactItem['completePhoneNumber2'],
        contactEmail: contactItem['contactEmail'],
        contactCategoryId: contactItem['contactCategoryId'],
      );

      await ref
          .read(contactProvider.notifier)
          .createContact(contact)
          .then((value) => context.go(RouteLocation.home));
    }
  }

  void _updateContact() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final contact = Contact(
        contactId: contactItem['contactId'],
        contactLastName: contactItem['contactLastName'],
        contactFirstName: contactItem['contactFirstName'],
        contactPhoneNumber1: contactItem['contactPhoneNumber1'],
        countryCode1: contactItem['countryCode1'],
        completePhoneNumber1: contactItem['completePhoneNumber1'],
        contactPhoneNumber2: contactItem['contactPhoneNumber2'],
        countryCode2: contactItem['countryCode2'],
        completePhoneNumber2: contactItem['completePhoneNumber2'],
        contactEmail: contactItem['contactEmail'],
        contactCategoryId: contactItem['contactCategoryId'],
      );

      await ref
          .read(contactProvider.notifier)
          .updateContact(contact)
          .then((value) => context.pop());
    }
  }
}
