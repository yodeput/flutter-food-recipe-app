import 'dart:async';

import 'package:foods_yodeput/data/model/model.dart';
import 'package:foods_yodeput/pages/application/fragment/home/index.dart';
import 'package:foods_yodeput/repository/reposiroty.dart';
import 'package:get/get.dart';

import 'index.dart';

class DetailController extends GetxController {
  final RecipeRepository repo;

  DetailController(this.repo);

  final DetailState state = DetailState();
  final HomeController homeController = Get.find();
  dynamic argumentData = Get.arguments;
  Recipe recipe = Recipe();


  setFavorit() async {
    recipe = await homeController.setFavorit(recipe);
    state.detail.isFavorit = recipe.isFavorit;
  }

  @override
  void onReady() {
    super.onReady();
    recipe = argumentData;
    fetchData(recipe.key!);
  }

  fetchData(String key) {
    repo.getRecipe(
        key: key,
        onSuccess: (data) async {
          state.detail = data;
          await getFavorit();
        },
        loading: (isLoading) {
          state.isLoading.value = isLoading;
        },
        onError: (error) {
          print("DetailController [fetchData]=> $error");
          throw error;
        });
  }

  getFavorit() async {
    var data = repo.getFavorite();
    state.favList.clear();
    state.favList.addAll(data);
    final index =
        state.favList.indexWhere((element) => element.key == recipe.key);
    if (index >= 0) {
      state.detail.isFavorit = true;
    }
  }
}
