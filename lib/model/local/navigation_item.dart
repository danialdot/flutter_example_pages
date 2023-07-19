import 'package:flutter/material.dart';

class CustomNavigationItem {
  final Icon icon;
  final String title;
  final StatefulWidget page;

  CustomNavigationItem({
    required this.icon,
    required this.title,
    required this.page,
  });
}
