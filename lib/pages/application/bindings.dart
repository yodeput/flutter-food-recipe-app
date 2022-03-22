import 'package:foods_yodeput/pages/favorite/index.dart';
import 'package:foods_yodeput/pages/home/index.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<FavoriteController>(() => FavoriteController());
  }
}
