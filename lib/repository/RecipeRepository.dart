import 'dart:convert';

import 'package:foods_yodeput/data/apis/apis.dart';
import 'package:foods_yodeput/common/constant/storage.dart';
import 'package:foods_yodeput/common/services/services.dart';
import 'package:foods_yodeput/common/utils/utils.dart';
import 'package:foods_yodeput/data/model/model.dart';
import 'package:get/get.dart';

class RecipeRepository extends GetxController {

  final RecipeApi api = RecipeApi();

  Future<void> getList({
    Function(List<Recipe> data)? onSuccess,
    Function(bool data)? loading,
    Function(dynamic error)? onError,
    int page = 1,
  }) async {
    loading!(true);
    api.fetchList(page).then((res) {
      var data = RecipeResponse.fromJson(res);
      onSuccess!(data.results!);
    }).catchError((error){
      onError!(error);
    }).whenComplete(() => loading(false));
  }

  Future<void> getRecipe({
    Function(Detail? data)? onSuccess,
    Function(bool data)? loading,
    Function(dynamic error)? onError,
    String? key,
  }) async {
    loading!(true);
    api.fetchRecipe(key!).then((res) {
      var data = DetailResponse.fromJson(res);
      onSuccess!(data.results);
    }).catchError((error){
      onError!(error);
    }).whenComplete(() => loading(false));
  }


  Future<Recipe> setFavorite(Recipe item) async {
    try {
      List<Recipe> data = getFavorite();
      final index = data.indexWhere((element) => element.key == item.key);
      if (index >= 0) {
        data.removeAt(index);

      } else {
        data.add(item);
      }
      item.isFavorit = !item.isFavorit;
      var stringify = jsonEncode(data);
      await StorageService.to.setString(STORAGE_FAVORIT_KEY, "");
      await StorageService.to.setString(STORAGE_FAVORIT_KEY, stringify);
      return item;
    } catch (error) {
      throw error;
    }
  }

  List<Recipe> getFavorite() {
    var data = StorageService.to.getString(STORAGE_FAVORIT_KEY);
    if (data.isNotEmpty) {
      List<dynamic> list = jsonDecode(data);
      var dataList = List<Recipe>.from(list.map((v) => Recipe.fromJson(v)));
      dataList.forEach((element) => element.isFavorit = true);
      return dataList;
    }
    return <Recipe>[];
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
}