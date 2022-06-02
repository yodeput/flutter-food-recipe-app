import 'dart:async';

import 'package:foods_yodeput/repository/reposiroty.dart';
import 'package:get/get.dart';
import 'index.dart';

class FavoriteController extends GetxController {
  FavoriteController(this.repo);
  final RecipeRepository repo;
  final state = FavoriteState();


  refreshData() async {
    await getFavorite(isRefresh: true);
  }

  getFavorite({bool isRefresh = false}) async {
    state.isLoading.value = isRefresh;
    var data = repo.getFavorite();
    state.favList.clear();
    var _duration = Duration(milliseconds: isRefresh ? 1000 : 0);
    Timer(_duration, () {
      state.favList.addAll(data);
      state.isLoading.value = false;
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
