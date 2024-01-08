import 'package:flutter/material.dart';

@immutable
class DbKeys {
  const DbKeys._();

  static const String dbName = 'contact.db';
  static const String dbContactTable = 'contact';
  static const String dbCategoryTable = 'category';
}
