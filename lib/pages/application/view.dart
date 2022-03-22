import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foods_yodeput/common/constant/values.dart';
import 'package:foods_yodeput/common/style/style.dart';
import 'package:foods_yodeput/common/widgets/widgets.dart';
import 'package:foods_yodeput/gen/assets.gen.dart';
import 'package:foods_yodeput/pages/favorite/index.dart';
import 'package:foods_yodeput/pages/home/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class ApplicationPage extends GetView<ApplicationController> {
  AppBar _buildAppBar() {
    return transparentAppBar(
      title: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            controller.tabTitles[controller.state.page] == 'Foodies'
                ? Row(
                    children: [
                      SvgPicture.asset(
                        Assets.images.logoOnly,
                        semanticsLabel: 'Logo',
                        height: 30,
                        width: 30,
                      ),
                      SizedBox.fromSize(
                        size: Size(10, 10),
                      ),
                    ],
                  )
                : SizedBox.fromSize(
                    size: Size(0, 0),
                  ),
            Text(
              controller.tabTitles[controller.state.page].toUpperCase(),
              style: TextStyle(
                color: AppColor.onBackground,
                fontFamily: 'Montserrat',
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        HomePage(),
        FavoritePage(),
      ],
      controller: controller.pageController,
      onPageChanged: controller.handlePageChanged,
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(() => BottomNavigationBar(
          items: controller.bottomTabs,
          currentIndex: controller.state.page,
          // fixedColor: AppColors.primaryElement,
          type: BottomNavigationBarType.fixed,
          onTap: controller.handleNavBarTap,
          selectedItemColor: AppColor.primary,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          selectedLabelStyle:
              TextStyle(color: AppColor.primary, fontWeight: FontWeight.bold),
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: AppColor.primary,
          statusBarIconBrightness: Brightness.light));
    }
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
