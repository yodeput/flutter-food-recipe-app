import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foods_yodeput/common/style/style.dart';
import 'package:foods_yodeput/common/widgets/widgets.dart';
import 'package:get/get.dart';
import 'index.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    AppTheme.setStatusBarColor(color: AppColor.background);
    return Obx(() {
      return controller.state.isLoading.value
          ? loadingWidget()
          : controller.state.dataList.length < 1
              ? loadingWidget()
              : RecipeList();
    });
  }
}
