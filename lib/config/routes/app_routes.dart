import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:contacts_manager/config/routes/routes.dart';
import 'package:contacts_manager/screens/screens.dart';

final navigationKey = GlobalKey<NavigatorState>();
final appRoutes = [
  GoRoute(
    path: RouteLocation.home,
    parentNavigatorKey: navigationKey,
    builder: HomeScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.createContact,
    parentNavigatorKey: navigationKey,
    builder: CreateContactScreen.builder,
  )
];
