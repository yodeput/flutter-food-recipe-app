import 'package:flutter/material.dart';
import 'color.dart';

class AppTheme {
  static const horizontalMargin = 16.0;
  static const radius = 10.0;

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColor.primary,
      fontFamily: "Montserrat",
  );
}
