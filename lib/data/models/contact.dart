import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final int? contactId;
  final String contactLastName;
  final String contactFirstName;
  final int? categoryId;

  const Contact({
    this.contactId,
    required this.contactLastName,
    required this.contactFirstName,
    this.categoryId,
  });

  @override
  List<Object> get props {
    return [
      contactId!,
      contactLastName,
      contactFirstName,
      categoryId!,
    ];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'contactId': contactId,
      'contactLastName': contactLastName,
      'contactFirstName': contactFirstName,
      'categoryId': categoryId,
    };
  }

  factory Contact.fromJson(Map<String, dynamic> map) {
    return Contact(
      contactId: map['contactId'],
      contactLastName: map['contactLastName'],
      contactFirstName: map['contactFirstName'],
      categoryId: map['categoryId'],
    );
  }

  Contact copyWith({
    int? contactId,
    String? contactLastName,
    String? contactFirstName,
    int? categoryId,
  }) {
    return Contact(
      contactId: contactId ?? this.contactId,
      contactLastName: contactLastName ?? this.contactLastName,
      contactFirstName: contactFirstName ?? this.contactFirstName,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}
