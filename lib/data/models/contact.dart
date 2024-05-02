import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final int? contactId;
  final String? contactLastName;
  final String? contactFirstName;
  final String? contactPhoneNumber1;
  final String countryCode1;
  final String? completePhoneNumber1;
  final String? contactPhoneNumber2;
  final String countryCode2;
  final String? completePhoneNumber2;
  final String? contactEmail;
  final int? contactCategoryId;

  const Contact({
    this.contactId,
    this.contactLastName,
    this.contactFirstName,
    this.contactPhoneNumber1,
    required this.countryCode1,
    this.completePhoneNumber1,
    required this.countryCode2,
    this.contactPhoneNumber2,
    this.completePhoneNumber2,
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
      countryCode1,
      completePhoneNumber1!,
      contactPhoneNumber2!,
      countryCode2,
      completePhoneNumber2!,
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
      'countryCode1': countryCode1,
      'completePhoneNumber1': completePhoneNumber1,
      'contactPhoneNumber2': contactPhoneNumber2,
      'countryCode2': countryCode2,
      'completePhoneNumber2': completePhoneNumber2,
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
      countryCode1: map['countryCode1'],
      completePhoneNumber1: map['completePhoneNumber1'],
      countryCode2: map['countryCode2'],
      contactPhoneNumber2: map['contactPhoneNumber2'],
      completePhoneNumber2: map['completePhoneNumber2'],
      contactEmail: map['contactEmail'],
      contactCategoryId: map['contactCategoryId'],
    );
  }

Contact copyWith({
    int? contactId,
    String? contactLastName,
    String? contactFirstName,
    String? contactPhoneNumber1,
    String? countryCode1,
    String? completePhoneNumber1,
    String? contactPhoneNumber2,
    String? countryCode2,
    String? completePhoneNumber2,
    String? contactEmail,
    int? contactCategoryId,
  }) {
    return Contact(
      contactId: contactId ?? this.contactId,
      contactLastName: contactLastName ?? this.contactLastName,
      contactFirstName: contactFirstName ?? this.contactFirstName,
      contactPhoneNumber1: contactPhoneNumber1 ?? this.contactPhoneNumber1,
      countryCode1: countryCode1 ?? this.countryCode1,
      completePhoneNumber1: completePhoneNumber1 ?? this.completePhoneNumber1,
      contactPhoneNumber2: contactPhoneNumber2 ?? this.contactPhoneNumber2,
      countryCode2: countryCode2 ?? this.countryCode2,
      completePhoneNumber2: completePhoneNumber2 ?? this.completePhoneNumber2,
      contactEmail: contactEmail ?? this.contactEmail,
      contactCategoryId: contactCategoryId ?? this.contactCategoryId,
    );
  }
}
