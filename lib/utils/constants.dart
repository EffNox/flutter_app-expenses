import 'package:flutter/material.dart';

class Constants {
  static sheetBoxDecoration(Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    );
  }

  static customButton(Color decoration, Color border, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: decoration,
          border: Border.all(color: border),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
