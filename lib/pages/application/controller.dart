import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foods_yodeput/common/routes/routes.dart';
import 'package:foods_yodeput/common/store/store.dart';
import 'package:foods_yodeput/common/style/style.dart';
import 'package:foods_yodeput/common/utils/utils.dart';
import 'package:foods_yodeput/pages/favorite/index.dart';
import 'package:foods_yodeput/pages/home/index.dart';
import 'package:get/get.dart';

import 'index.dart';

class ApplicationController extends GetxController {
  ApplicationController();

  final state = ApplicationState();

  late final List<String> tabTitles;

  late final PageController pageController;

  late final List<BottomNavigationBarItem> bottomTabs;

  final FavoriteController favController = Get.find();
  final HomeController homeController = Get.find();

  void handleNavBarTap(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);

    if(index == 0) homeController.refreshData();
    else favController.getFavorite();
  }

  void handlePageChanged(int page) {
    state.page = page;
  }

  void setNavigationBar(){
    tabTitles = ['Foodies', 'Favorite'];
    bottomTabs = <BottomNavigationBarItem>[
      new BottomNavigationBarItem(
        icon: Icon(
          Iconfont.home,
          color: AppColor.secondary,
        ),
        activeIcon: Icon(
          Iconfont.home,
          color: AppColor.primary,
        ),
        label: 'Foodies',
        backgroundColor: AppColor.primaryContainer,
      ),
      new BottomNavigationBarItem(
        icon: Icon(
          Iconfont.fav,
          color: AppColor.secondary,
        ),
        activeIcon: Icon(
          Iconfont.fav,
          color: AppColor.primary,
        ),
        label: 'Favorite',
        backgroundColor: AppColor.primaryContainer,
      ),
    ];
    pageController = new PageController(initialPage: state.page);
  }

  @override
  void onInit() {
    super.onInit();
    setNavigationBar();
  }

  showWelcomePage() {
    if (ConfigStore.to.skipWelcome == false) {
      Get.toNamed(AppRoutes.WELCOME);
    }
  }

  @override
  void onReady() {
    super.onReady();
    showWelcomePage();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
