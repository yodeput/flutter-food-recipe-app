import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'color.dart';

class AppTheme {
  static const horizontalMargin = 16.0;
  static const radius = 10.0;

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColor.primary,
      fontFamily: "Montserrat",
  );

  static setStatusBarColor({Color color = AppColor.primary}){
    if (GetPlatform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: color,
          statusBarIconBrightness: Brightness.dark));
    }
  }
}
