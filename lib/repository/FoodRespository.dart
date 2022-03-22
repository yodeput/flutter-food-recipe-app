import 'dart:convert';

import 'package:foods_yodeput/common/apis/apis.dart';
import 'package:foods_yodeput/common/constant/storage.dart';
import 'package:foods_yodeput/common/services/services.dart';
import 'package:foods_yodeput/model/food.dart';
import 'package:get/get.dart';

class FoodRespository extends GetxController {

  final FoodsApi api = FoodsApi();

  Future getData({
    Function(List<Food> data)? onSuccess,
    Function(bool data)? loading,
    Function(dynamic error)? onError,
  }) async {
    loading!(true);
    api.getFoods().then((res) {
      var data = List<Food>.from(res.map((v) => Food.fromJson(v)));
      onSuccess!(data);
    }).catchError((error){
      onError!(error);
    }).whenComplete(() => loading(false));
  }


  Future<bool> setFavorite(Food item) async {
    try {
      List<Food> data = getFavorite();
      final index = data.indexWhere((element) => element.name!.toLowerCase() == item.name!.toLowerCase());
      if (index >= 0) {
        data.removeAt(index);
      } else {
        data.add(item);
      }
      var stringify = jsonEncode(data);
      await StorageService.to.setString(STORAGE_FAVORIT_KEY, "");
      await StorageService.to.setString(STORAGE_FAVORIT_KEY, stringify);
      return true;
    } catch (error) {
      print("setFavorite >>> ${error}");
      return false;
    }
  }

  List<Food> getFavorite() {
    var data = StorageService.to.getString(STORAGE_FAVORIT_KEY);
    if (data.isNotEmpty) {
      List<dynamic> list = jsonDecode(data);
      var dataList = List<Food>.from(list.map((v) => Food.fromJson(v)));
      dataList.forEach((element) => element.isFavorit = true);
      return dataList;
    }
    return [];
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