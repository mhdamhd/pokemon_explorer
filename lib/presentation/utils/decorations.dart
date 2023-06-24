import 'package:pokemon_explorer/res/app_res.dart';
import 'package:flutter/material.dart';

class Decorations {
  Decorations._();
  static InputDecoration decorateTextField() {
    return InputDecoration(
      fillColor: Colors.grey.shade200,
      filled: true,
      isCollapsed: false,
      isDense: false, border: InputBorder.none,
    );
  }

  static InputDecoration decorateDropDownField() => InputDecoration(
        border: InputBorder.none,
        fillColor: Colors.grey.shade200,
        filled: true,
        isCollapsed: false,
        isDense: false,
        errorStyle: Styles.errorStyle,
      );
}
