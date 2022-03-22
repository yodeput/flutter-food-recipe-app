import 'package:get/get.dart';

class ApplicationState {
  final _page = 0.obs;
  set page(value) => this._page.value = value;
  get page => this._page.value;
}
