import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contacts_manager/app/contacts_manager_app.dart';




void main() {
  runApp(const ProviderScope(child: ContactsManagerApp()));
}

