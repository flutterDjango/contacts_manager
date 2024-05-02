import 'package:flutter/material.dart';

@immutable
class RouteLocation {
  const RouteLocation._();
  static String get home => '/home';
  static String get createContact => '/createContact';
  static String get category => '/category';
}
