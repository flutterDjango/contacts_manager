import 'package:contacts_manager/data/repositories/contacts/contact_repository_provider.dart';
import 'package:contacts_manager/providers/contact/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactProvider = StateNotifierProvider<ContactNotifier, ContactState>((ref) 
{
  final repository = ref.watch(contactRepositoryProvider);
  return ContactNotifier(repository);
});