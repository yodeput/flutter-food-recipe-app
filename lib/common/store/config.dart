import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foods_yodeput/common/services/services.dart';
import 'package:foods_yodeput/common/constant/values.dart';
import 'package:foods_yodeput/model/food.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ConfigStore extends GetxController {
  static ConfigStore get to => Get.find();

  bool skipWelcome = false;
  PackageInfo? _platform;

  String get version => _platform?.version ?? '-';

  bool get isRelease => bool.fromEnvironment("dart.vm.product");
  Locale locale = Locale('en', 'US');
  List<Locale> languages = [
    Locale('en', 'US'),
    Locale('zh', 'CN'),
  ];

  @override
  void onInit() {
    super.onInit();
    skipWelcome = StorageService.to.getBool(STORAGE_SKIP_WELCOME);
  }

  Future<void> getPlatform() async {
    _platform = await PackageInfo.fromPlatform();
  }

  // User already open the APP
  Future<bool> saveAlreadyOpen() {
    return StorageService.to.setBool(STORAGE_SKIP_WELCOME, true);
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

  void onInitLocale() {
    var langCode = StorageService.to.getString(STORAGE_LANGUAGE_CODE);
    if (langCode.isEmpty) return;
    var index = languages.indexWhere((element) {
      return element.languageCode == langCode;
    });
    if (index < 0) return;
    locale = languages[index];
  }

  void onLocaleUpdate(Locale value) {
    locale = value;
    Get.updateLocale(value);
    StorageService.to.setString(STORAGE_LANGUAGE_CODE, value.languageCode);
  }
}
