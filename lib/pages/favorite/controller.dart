import 'dart:async';

import 'package:foods_yodeput/common/store/store.dart';
import 'package:foods_yodeput/repository/FoodRespository.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'index.dart';

class FavoriteController extends GetxController {
  FavoriteController(this.repository);
  final FoodRespository repository;
  final state = FavoriteState();


  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  refreshData() async {
    await getFavorite(isRefresh: true);
    refreshController.refreshCompleted(resetFooterState: false);
  }
  getFavorite({bool isRefresh = false}) async {
    var data = repository.getFavorite();
    state.favList = null;
    var _duration = Duration(milliseconds: !isRefresh ? 1000 : 0);
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
