import 'package:equatable/equatable.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:intl_phone_field/phone_number.dart';

class Contact extends Equatable {
  final int? contactId;
  final String? contactLastName;
  final String? contactFirstName;
  final String? contactPhoneNumber1;
  final String? contactPhoneNumber2;
  final String? contactEmail;
  final int? contactCategoryId;

  const Contact({
    this.contactId,
    this.contactLastName,
    required this.contactFirstName,
    required this.contactPhoneNumber1,
    this.contactPhoneNumber2,
    this.contactEmail,
    this.contactCategoryId,
  });

  @override
  List<Object> get props {
    return [
      contactId!,
      contactLastName!,
      contactFirstName!,
      contactPhoneNumber1!,
      contactPhoneNumber2!,
      contactEmail!,
      contactCategoryId!,
    ];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'contactId': contactId,
      'contactLastName': contactLastName,
      'contactFirstName': contactFirstName,
      'contactPhoneNumber1': contactPhoneNumber1,
      'contactPhoneNumber2': contactPhoneNumber2,
      'contactEmail': contactEmail,
      'contactCategoryId': contactCategoryId,
    };
  }

  factory Contact.fromJson(Map<String, dynamic> map) {
    return Contact(
      contactId: map['contactId'],
      contactLastName: map['contactLastName'],
      contactFirstName: map['contactFirstName'],
      contactPhoneNumber1: map['contactPhoneNumber1'],
      contactPhoneNumber2: map['contactPhoneNumber2'],
      contactEmail: map['contactEmail'],
      contactCategoryId: map['contactCategoryId'],
    );
  }

  Contact copyWith({
    int? contactId,
    String? contactLastName,
    String? contactFirstName,
    String? contactPhoneNumber1,
    String? contactPhoneNumber2,
    String? contactEmail,
    int? contactCategoryId,
  }) {
    return Contact(
      contactId: contactId ?? this.contactId,
      contactLastName: contactLastName ?? this.contactLastName,
      contactFirstName: contactFirstName ?? this.contactFirstName,
      contactPhoneNumber1: contactPhoneNumber1 ?? this.contactPhoneNumber1,
      contactPhoneNumber2: contactPhoneNumber2 ?? this.contactPhoneNumber2,
      contactEmail: contactEmail ?? this.contactEmail,
      contactCategoryId: contactCategoryId ?? this.contactCategoryId,
    );
  }
}
