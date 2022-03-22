import 'package:get/get.dart';

import 'controller.dart';

class DetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailController>(() => DetailController());
  }
}
