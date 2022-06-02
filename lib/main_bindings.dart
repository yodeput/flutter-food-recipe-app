import 'package:foods_yodeput/repository/reposiroty.dart';
import 'package:get/get.dart';

import 'common/store/config.dart';

class MainBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<ConfigStore>(ConfigStore(), permanent: true);
    Get.put<RecipeRepository>(RecipeRepository(), permanent: true);
  }
}
