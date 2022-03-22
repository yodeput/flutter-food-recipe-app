import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_yodeput/common/style/style.dart';
import 'package:foods_yodeput/gen/assets.gen.dart';
import 'package:lottie/lottie.dart';

AppBar transparentAppBar({
  Widget? title,
  Widget? leading,
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: title != null
        ? Center(
            child: title,
          )
        : null,
    leading: leading,
    actions: actions,
  );
}

Widget divider10Px({Color bgColor = AppColor.secondary}) {
  return Container(
    height: 10.w,
    decoration: BoxDecoration(
      color: bgColor,
    ),
  );
}

Widget loadingWidget() {
  return Center(
    child: Lottie.asset(
      Assets.lottie.cook,
      width: 300.w,
      height: 300.h,
      fit: BoxFit.fill,
    ),);
}


Widget noDataWidget({required String message}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Lottie.asset(
        Assets.lottie.cook,
        width: 300.w,
        height: 300.h,
        fit: BoxFit.fill,
      ),
      Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColor.onBackground,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
            fontSize: 22.sp,
            height: 1,
          ),
        ),
      ),
    ],
  );
}


