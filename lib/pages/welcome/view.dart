import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foods_yodeput/common/constant/values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_yodeput/common/style/style.dart';
import 'package:foods_yodeput/gen/assets.gen.dart';
import 'package:get/get.dart';

import 'index.dart';

class WelcomePage extends GetView<WelcomeController> {
  Widget _buildPageHeadTitle() {
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

  Widget _buildLogo() {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: SvgPicture.asset(Assets.images.logo, semanticsLabel: 'Logo'),
    );
  }

  Widget _buildFeatureItem(String imageName, String intro, double marginTop) {
    return Container(
      width: 295.w,
      height: 80.h,
      margin: EdgeInsets.only(top: marginTop.h),
      child: Row(
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            child: SvgPicture.asset(Assets.images.logoOnly, semanticsLabel: 'Logo')
          ),
          Spacer(),
          Container(
            width: 195.w,
            child: Text(
              intro,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: AppColor.onBackground,
                fontFamily: "Avenir",
                fontWeight: FontWeight.normal,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return Container(
      width: 295.w,
      height: 44.h,
      margin: EdgeInsets.only(bottom: 20.h),
      child: TextButton(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(TextStyle(
            fontSize: 16.sp,
            color: AppColor.primary
          )),
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.focused) &&
                  !states.contains(MaterialState.pressed)) {
                return AppColor.onPrimaryContainer;
              } else if (states.contains(MaterialState.pressed)) {
                return AppColor.dangerColor;
              }
              return AppColor.onPrimary;
            },
          ),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return AppColor.primary;
            }
            return AppColor.onPrimary;
          }),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: Radii.k6pxRadius,
          )),
        ),
        child: Text("Get started", style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.primary
        )),
        onPressed: controller.navigateToMain,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary
      ,
      body: Center(
        child: Column(
          children: <Widget>[
            _buildLogo(),
            _buildPageHeadTitle(),
            _buildFeatureItem(
              "feature-1",
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
              40,
            ),
            _buildFeatureItem(
              "feature-2",
              "Lorem ipsum dolor sit amet, consectetur adipiscing",
              30,
            ),
            _buildFeatureItem(
              "feature-3",
              "Lorem ipsum dolor sit amet, consectetur adipiscing",
              30,
            ),
            Spacer(),
            _buildStartButton(context),
          ],
        ),
      ),
    );
  }
}
