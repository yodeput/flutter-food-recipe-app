
import 'package:foods_yodeput/pages/application/fragment/favorite/index.dart';
import 'package:foods_yodeput/pages/application/fragment/home/index.dart';
import 'package:foods_yodeput/pages/detail/index.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    Get.lazyPut<HomeController>(() => HomeController(Get.find()));
    Get.lazyPut<FavoriteController>(() => FavoriteController(Get.find()));
  }
}
