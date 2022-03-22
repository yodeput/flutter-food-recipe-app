import 'package:foods_yodeput/model/food.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class WelcomeState {
  var _food = Rx<Food>(Food());
  set food(value) => _food.value = value;
  get food => _food.value;

  // WelcomeState() {}
}
