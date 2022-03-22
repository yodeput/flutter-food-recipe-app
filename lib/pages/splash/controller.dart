import 'dart:async';

import 'package:foods_yodeput/common/routes/routes.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'index.dart';

class SplashController extends GetxController {
  final state = WelcomeState();

  SplashController();

  startTimer() {
    var _duration = Duration(milliseconds: 1500);
    return Timer(_duration, navigate);
  }

  navigate() async {
    Get.offAllNamed(AppRoutes.APP);
  }

  getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    state.appVersion = "v ${packageInfo.version}";
  }

  @override
  void onInit() {
    getAppInfo();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
