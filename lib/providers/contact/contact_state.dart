import 'package:contacts_manager/data/models/models.dart';
import 'package:equatable/equatable.dart';


class ContactState extends Equatable {
  const ContactState(this.contacts);
  
  const ContactState.initial({this.contacts= const []});
  final List<Contact> contacts;

  ContactState copyWith({
    List<Contact>? contacts,
  }) {
    return ContactState(contacts ?? this.contacts);
  }
  @override
  List<Object> get props => [contacts];

}