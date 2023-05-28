import 'package:expenses/utils/icon_list.dart';
import 'package:flutter/material.dart';
// export 'package:expenses/utils/utils.dart';

extension ColorExtension on String {
  toColor() {
    String hexColor = replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    if (hexColor.length == 8) {
      return Color(int.parse('0x$hexColor'));
    }
  }
}

extension IconExtension on String {
  toIcon() => IconList().iconMap[this];
}

extension StringExtensions on String {
  bool containsIgnoreCase(String v) => toLowerCase() == v.toLowerCase();
  // bool containsIgnoreCase(String v) => toLowerCase().contains(v.toLowerCase());
  // bool isNotBlank() => this != null && this.isNotEmpty;
}

// extension IterableExtension on List {
extension IterableExtension on Iterable {
  containsIgnoreCase(String value) =>
      map((v) => v.toLowerCase()).contains(value.toLowerCase());
  // map((v) => v.toLowerCase()).toList().contains(value.toLowerCase());
}

// int daysInMonth(int month) {
// var now = DateTime.now();
// var lastDay = (month < 12)
// ? DateTime(now.year, month + 1, 0)
// : DateTime(now.year + 1, 1, 0);
// return lastDay.day;
// }
int daysInMonth(int month) => DateTime.now().month != month
    ? DateTime(DateTime.now().year, month + 1, 0).day
    : DateTime.now().day;
