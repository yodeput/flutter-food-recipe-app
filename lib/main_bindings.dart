import 'package:foods_yodeput/repository/FoodRespository.dart';
import 'package:get/get.dart';

import 'common/services/storage.dart';
import 'common/store/config.dart';

class MainBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<ConfigStore>(ConfigStore(), permanent: true);
    Get.put<FoodRespository>(FoodRespository(), permanent: true);
  }
}
