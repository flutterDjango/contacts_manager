import 'package:contacts_manager/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:contacts_manager/data/data.dart';

class ValidFieldForm {
  static String? validStringFieldNotEmpty(String? value, int nbMaxChar) {
    if (value == null ||
        value.isEmpty ||
        value.trim().length <= 1 ||
        value.trim().length > nbMaxChar) {
      return 'Entrer entre 2 et $nbMaxChar caratères.';
    }
    return null;
  }

  static String? validStringField(String? value, int nbMaxChar) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (value.trim().length <= 1 || value.trim().length > nbMaxChar) {
      return 'Entre 1 et $nbMaxChar caratères.';
    }
    return null;
  }

  static bool lastNameAndFirstNameEmpty({String? lastName, String? firstName}) {
    if ((lastName == null || lastName.isEmpty) &&
        (firstName == null || firstName.isEmpty)) {
      return true;
    }
    return false;
  }

  static bool phonesAndEmailEmpty(
      {String? phoneNumber1, String? phoneNumber2, String? email}) {
    if ((phoneNumber1 == null || phoneNumber1.isEmpty) &&
        (phoneNumber2 == null || phoneNumber2.isEmpty) &&
        (email == null || email.isEmpty)) {
      return true;
    }
    return false;
  }

  static bool isPhoneAlreadyExist(
      {TextEditingController? controller,
      Contact? contact,
      String? phoneCountryCode,
      List<Contact>? contacts}) {
    if (phoneCountryCode != null && controller != null && contacts != null) {
      final assignedPhone = contacts.where(
        (element) =>
            element.completePhoneNumber1 ==
                phoneCountryCode + controller.text.trim() ||
            element.completePhoneNumber2 ==
                phoneCountryCode + controller.text.trim(),
      );
      if (assignedPhone.isNotEmpty) {
        final int? contactId = (contact == null) ? null : contact.contactId;
        if (assignedPhone.first.contactId == contactId) {
          return false;
        }
        return true;
      }
      return false;
    }
    return false;
  }

  static bool isEmailAlreadyExist({
    TextEditingController? controller,
    Contact? contact,
    List<Contact>? contacts,
  }) {
    if (controller != null && contacts != null && controller.text != "") {
      final assignedEmail = contacts
          .where((element) => element.contactEmail == controller.text.trim());

      if (assignedEmail.isNotEmpty) {
        final int? contactId = (contact == null) ? null : contact.contactId;
        if (assignedEmail.first.contactId == contactId) {
          return false;
        }
        return true;
      }
      return false;
    }
    return false;
  }

  static Map<String, String?> checkIfPhoneAlreadyExist(
    List<Contact> allContacts,
    Contact? contact,
    Map<String, TextEditingController> controllers,
    Map<String, String> phoneCountryCode,
    bool phoneFieldOnFocus,
  ) {
    const String messagePhoneNumberExist = "Ce numéro existe déjà";
    final TextEditingController phoneNumber1Controller =
        controllers['phoneNumber1Controller']!;
    final TextEditingController phoneNumber2Controller =
        controllers['phoneNumber2Controller']!;
    final Map<String, String?> phoneExist = {};

    final bool phone1Exist = ValidFieldForm.isPhoneAlreadyExist(
      controller: phoneNumber1Controller,
      contact: contact,
      phoneCountryCode: phoneCountryCode["countryCode1"],
      contacts: allContacts,
    );
    final bool phone2Exist = ValidFieldForm.isPhoneAlreadyExist(
      controller: phoneNumber2Controller,
      contact: contact,
      phoneCountryCode: phoneCountryCode["countryCode2"],
      contacts: allContacts,
    );

    if (phone1Exist) {
      (!phoneFieldOnFocus)
          ? phoneExist['phoneExist1'] = messagePhoneNumberExist
          : phoneExist['phoneExist1'] = null;
    } else {
      phoneExist['phoneExist1'] = null;
    }
    if (phone2Exist) {
      (!phoneFieldOnFocus)
          ? phoneExist['phoneExist2'] = messagePhoneNumberExist
          : phoneExist['phoneExist2'] = null;
    } else {
      phoneExist['phoneExist2'] = null;
    }
    return phoneExist;
  }

  static String? checkIfEmailAlreadyExist(
    List<Contact> allContacts,
    Contact? contact,
    TextEditingController controller,
    bool emailFieldOnFocus,
  ) {
    final bool emailExist = ValidFieldForm.isEmailAlreadyExist(
      controller: controller,
      contact: contact,
      contacts: allContacts,
    );

    if (emailExist) {
      if (!emailFieldOnFocus) {
        return "Cet email existe déjà.";
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<bool> checkIfTheContactCanBeReachead(
      Map<String, TextEditingController> controllers, context) async {
    final TextEditingController phoneNumber1Controller =
        controllers['phoneNumber1Controller']!;
    final TextEditingController phoneNumber2Controller =
        controllers['phoneNumber2Controller']!;
    final TextEditingController lastNameController =
        controllers['lastNameController']!;
    final TextEditingController firstNameController =
        controllers['firstNameController']!;
    final TextEditingController emailController =
        controllers['emailController']!;

    bool anonymousContact = ValidFieldForm.lastNameAndFirstNameEmpty(
      lastName: lastNameController.text.trim(),
      firstName: firstNameController.text.trim(),
    );
    bool noWayToContact = ValidFieldForm.phonesAndEmailEmpty(
      phoneNumber1: phoneNumber1Controller.text.trim(),
      phoneNumber2: phoneNumber2Controller.text.trim(),
      email: emailController.text.trim(),
    );

    if (anonymousContact) {
      await AppAlerts.showInformantionContactAlertDialog(
          context: context, message: 'Entrer un nom ou un prénom.');
      return false;
    }

    if (noWayToContact) {
      await AppAlerts.showInformantionContactAlertDialog(
          context: context,
          message: "Entrer au moins un numéro de téléphone ou l'email.");
      return false;
    }
    return true;
  }

  static Future<bool> checkIfPhoneNumbersAreTheSame(
      Map<String, TextEditingController> controllers,
      Map<String, String> phoneCountryCode,
      context) async {
    final String phoneNumber1 = controllers['phoneNumber1Controller']!.text;
    final String phoneNumber2 = controllers['phoneNumber2Controller']!.text;
    final String phoneCountryCode1 = phoneCountryCode["countryCode1"]!;
    final String phoneCountryCode2 = phoneCountryCode["countryCode2"]!;


    if (phoneCountryCode1 + phoneNumber1 == phoneCountryCode2 + phoneNumber2) {
      await AppAlerts.showInformantionContactAlertDialog(
          context: context,
          message: 'Les numéros de téléphone doivent être différents.');
      return true;
    }
    return false;
  }
}
