import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:contacts_manager/config/theme/app_theme.dart';
import 'package:contacts_manager/config/routes/routes.dart';


class ContactsManagerApp extends ConsumerWidget {
  const ContactsManagerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeConfig = ref.watch(routesProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: routeConfig,
    );
  }
}