import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class WelcomeState {
  var _appVersion = "".obs;
  set appVersion(value) => this._appVersion.value = value;
  get appVersion => this._appVersion.value;

  // WelcomeState() {}
}
