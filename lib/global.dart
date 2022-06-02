import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foods_yodeput/common/services/services.dart';
import 'package:foods_yodeput/common/style/style.dart';
import 'package:get/get.dart';

class Global {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    setSystemUi();

    await Get.putAsync<StorageService>(() => StorageService().init(), permanent: true);
  }

  static void setSystemUi() {
    if (GetPlatform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: AppColor.primary,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: AppColor.primary,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}
