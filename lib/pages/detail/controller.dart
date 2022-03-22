import 'dart:async';

import 'package:foods_yodeput/common/routes/routes.dart';
import 'package:foods_yodeput/pages/home/controller.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'index.dart';

class DetailController extends GetxController {
  final state = WelcomeState();
  final HomeController homeController = Get.find();

  dynamic argumentData = Get.arguments;
  DetailController();

  setFavorit(){
    homeController.setFavorit(state.food);
  }

  @override
  void onReady() {
    super.onReady();
    state.food = argumentData;
  }
}
