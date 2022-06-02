import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foods_yodeput/common/style/style.dart';
import 'package:foods_yodeput/gen/assets.gen.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

AppBar transparentAppBar({
  Widget? title,
  Widget? leading,
  List<Widget>? actions,
  Color statusBarColor = AppColor.primary
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: statusBarColor, statusBarIconBrightness: Brightness.dark),
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

Widget loadingWidget({double width = 300, double height = 300,}) {
  return Container(
    child: Center(
      child: Lottie.asset(
        Assets.lottie.cook,
        width: width.w,
        height: height.h,
        fit: BoxFit.fill,
      ),),
  );
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

Widget buildExtraDetailRow(IconData? icon, String data, {Color color = AppColor.onPrimary}) {
  return Row(
    children: [
      FaIcon(
        icon,
        color: color,
        size: 10,
      ),
      SizedBox(
        width: 5,
        height: 5,
      ),
      Text(
        data,
        style: Theme.of(Get.context!)
            .textTheme
            .bodySmall!
            .copyWith(color: color, fontWeight: FontWeight.bold),
      )
    ],
  );
}


