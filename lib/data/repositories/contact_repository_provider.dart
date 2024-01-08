import 'package:contacts_manager/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final contactRepositoryProvider = Provider<ContactRepository>((ref) {
final datasource = ref.watch(databaseProvider);
return ContactRepositoryImpl(datasource);
});

