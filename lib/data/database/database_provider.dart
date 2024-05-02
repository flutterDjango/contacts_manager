import 'package:contacts_manager/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final databaseProvider = Provider<ContactDatabase>(
  (ref) {
    return ContactDatabase();
  },
);