import 'package:foods_yodeput/pages/detail/controller.dart';
import 'package:get/get.dart';

import 'controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(Get.find()));
  }
}
