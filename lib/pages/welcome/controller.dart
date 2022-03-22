import 'package:foods_yodeput/common/routes/routes.dart';
import 'package:foods_yodeput/common/store/store.dart';
import 'package:get/get.dart';

import 'index.dart';

class WelcomeController extends GetxController {
  final state = WelcomeState();

  WelcomeController();

  navigateToMain() async {
    await ConfigStore.to.saveAlreadyOpen();
    Get.back();
  }


  @override
  void onReady() {
    super.onReady();
  }
}
