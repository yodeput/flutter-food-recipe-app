import 'dart:async';

import 'package:foods_yodeput/common/utils/utils.dart';
import 'package:foods_yodeput/common/widgets/widgets.dart';
import 'package:foods_yodeput/data/model/recipe.dart';
import 'package:foods_yodeput/repository/reposiroty.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'index.dart';

class HomeController extends GetxController {
  HomeController(this.repo);

  final RecipeRepository repo;

  final RefreshController refreshController = RefreshController();

  final state = HomeState();

  refreshData() async {
    fetchData(isRefresh: true).then((_) {
      refreshController.refreshCompleted();
    }).catchError((_) {
      refreshController.refreshFailed();
    });
  }

  loadData() async {
    fetchData().then((_) {
      refreshController.loadComplete();
    }).catchError((_) {
      refreshController.loadFailed();
    });
  }

  Future<void> fetchData({bool isRefresh = false}) async {
    if (isRefresh) {
      state.page.value = 0;
      state.dataList.clear();
      state.isLoading.value = true;
    }
    repo.getList(
        page: state.page.value + 1,
        onSuccess: (data) async {
          await getFavorit();
          state.dataList.addAll(data);
          state.isLoading.value = false;
        },
        loading: (isLoading) {
        },
        onError: (error) {
          Logger.error("[$runtimeType fetchData] => $error");
          throw error;
        });
  }

  Future<Recipe> setFavorit(Recipe data) async {
    try {
      data = await repo.setFavorite(data);
      if (data.isFavorit) {
        toastSuccess(msg: 'Marked as Favorite is Success');
      } else {
        toastSuccess(msg: 'Unfavorite recipe is Success');
      }
      return data;
    } catch (error) {
      toastDanger(msg: 'Marked as Favorite is Failed');
      Logger.error("[setFavorit]=> $error");
      return data;
    }
  }

  getFavorit() async {
    var data = repo.getFavorite();
    state.favList.clear();
    state.favList.addAll(data);
    state.dataList.forEach((v) {
      v.isFavorit = false;
      if (state.favList.length > 0) {
        final index = state.favList.indexWhere((element) =>
        element.key == v.key);
        if (index >= 0) {
          v.isFavorit = true;
        }
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
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
