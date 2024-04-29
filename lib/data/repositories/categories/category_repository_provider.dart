import 'package:contacts_manager/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
final datasource = ref.watch(databaseProvider);
return CategoryRepositoryImpl(datasource);
});

