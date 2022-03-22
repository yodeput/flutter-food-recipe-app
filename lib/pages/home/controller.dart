import 'dart:async';

import 'package:foods_yodeput/common/apis/apis.dart';
import 'package:foods_yodeput/common/store/store.dart';
import 'package:foods_yodeput/common/widgets/widgets.dart';
import 'package:foods_yodeput/model/food.dart';
import 'package:foods_yodeput/repository/FoodRespository.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'index.dart';

class HomeController extends GetxController {
  HomeController(this.repository);

  final FoodRespository repository;


  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  final state = HomeState();

  refreshData() async {
    await getFavorit();
      state.foodsList.forEach((v) {
        v.isFavorit = false;
        if (state.favList != null && state.favList.length > 0) {
          final index =
          state.favList.indexWhere((element) => element.name == v.name);
          if (index >= 0) {
            v.isFavorit = true;
          }
        }
      });
    refreshController.refreshCompleted(resetFooterState: false);
  }

  loadFoodsData() async {
    state.isLoading = true;
    state.foodsList = null;
    var _duration = Duration(milliseconds: 1500);
    Timer(_duration, () {
      repository.getData(onSuccess: (data) {
        state.foodsList = data;
        getFavorit();
        state.foodsList.forEach((v) {
          v.isFavorit = false;
          if (state.favList != null && state.favList.length > 0) {
            final index =
            state.favList.indexWhere((element) => element.name == v.name);
            if (index >= 0) {
              v.isFavorit = true;
            }
          }
        });
        refreshController.refreshCompleted(resetFooterState: false);
      }, loading: (isLoading) {
        state.isLoading = isLoading;
      }, onError: (error) {
        print("HomeController");
        print(error);
        refreshController.refreshFailed();
      });
    });
  }

  setFavorit(Food data) {
    repository.setFavorite(data).then((value) {
      if (data.isFavorit == false) {
        toastSuccess(msg: 'Marked as Favorite is Success');
        data.isFavorit = true;
      } else {
        toastSuccess(msg: 'Unfavorite recipe is Success');
        data.isFavorit = false;
      }
    }).catchError((onError) {
      toastDanger(msg: 'Marked as Favorite is Failed');
    });
  }

  getFavorit() async {
    var data = repository.getFavorite();
    state.favList = data;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loadFoodsData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }
}
