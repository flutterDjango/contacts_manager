import 'package:flutter/material.dart';
import 'package:contacts_manager/data/data.dart';

class ValidFieldForm {
  static String? validStringFieldNotEmpty(String? value, int nbMaxChar) {
    if (value == null ||
        value.isEmpty ||
        value.trim().length <= 1 ||
        value.trim().length > nbMaxChar) {
      return 'Entrer entre 1 et $nbMaxChar caratères.';
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

  static bool lastNameAndFirstNameEmpty(
      {String? lastName, String? firstName}) {
    if (lastName == null ||
        lastName.isEmpty && (firstName == null || firstName.isEmpty)) {
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
      String? phoneCountryCode,
      List<Contact>? contacts}) {
    if (phoneCountryCode != null && controller != null && contacts != null) {
      final assignedPhone = contacts.where(
        (element) =>
            element.contactPhoneNumber1 ==
                phoneCountryCode + controller.text.trim() ||
            element.contactPhoneNumber2 ==
                phoneCountryCode + controller.text.trim(),
      );
      if (assignedPhone.isNotEmpty) {
        return true;
      }
      return false;
    }
    return false;
  }

  static bool isEmailAlreadyExist(
      {TextEditingController? controller, List<Contact>? contacts}) {
    if (controller != null && contacts != null) {
      final assignedEmail = contacts
          .where((element) => element.contactEmail == controller.text.trim());
      if (assignedEmail.isNotEmpty) {
        return true;
      }
      return false;
    }
    return false;
  }

  
}
