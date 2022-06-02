import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foods_yodeput/common/constant/values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_yodeput/common/style/style.dart';
import 'package:foods_yodeput/gen/assets.gen.dart';
import 'package:get/get.dart';

import 'index.dart';

class SplashPage extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    AppTheme.setStatusBarColor();
    controller.startTimer();
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Column(
          children: <Widget>[
            _buildLogo(),
            _buildTitle(),
            Spacer(),
            _buildProgress(),
            _buildVersion()
          ],
        ),
      ),
    );
  }

  Padding _buildVersion() {
    return Padding(
            padding: EdgeInsets.only(bottom: (40 + 20.0).h, top: 30.h),
            child: Text(
              "${controller.state.appVersion}",
              style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
                  color: AppColor.onPrimary, fontWeight: FontWeight.bold),
            ),
          );
  }

  Widget _buildLogo() {
    return Padding(
      padding: EdgeInsets.only(top: (60 + 30.0).h),
      child: SvgPicture.asset(Assets.images.logo, semanticsLabel: 'Logo'),
    );
  }

  Widget _buildTitle() {
    return Container(
      child: Text(
        "FOODIES",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColor.onBackground,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
          fontSize: 45.sp,
          height: 1,
        ),
      ),
    );
  }

  Widget _buildProgress() {
    return CircularProgressIndicator(
      color: AppColor.onPrimary,
    );
  }
}
