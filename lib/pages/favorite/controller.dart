import 'dart:async';

import 'package:foods_yodeput/common/store/store.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'index.dart';

class FavoriteController extends GetxController {
  FavoriteController();

  final state = FavoriteState();

  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  refreshData() async {
    await getFavorite();
    refreshController.refreshCompleted(resetFooterState: false);
  }
  getFavorite() async {
    var data = ConfigStore().getFavorite();
    state.favList = null;
    var _duration = Duration(milliseconds: 1000);
    Timer(_duration, () {
      state.favList = data;
    });
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getFavorite();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
