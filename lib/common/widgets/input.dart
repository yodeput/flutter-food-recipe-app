import 'package:flutter/material.dart';
import 'package:foods_yodeput/common/constant/values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_yodeput/common/style/style.dart';

// Input Text
Widget inputTextEdit({
  TextEditingController? controller,
  TextInputType keyboardType = TextInputType.text,
  String? hintText,
  bool isPassword = false,
  double marginTop = 15,
  bool autofocus = false,
}) {
  return Container(
    height: 44.h,
    margin: EdgeInsets.only(top: marginTop.h),
    decoration: BoxDecoration(
      color: AppColor.background,
      borderRadius: Radii.k6pxRadius,
    ),
    child: TextField(
      autofocus: autofocus,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 9),
        border: InputBorder.none,
      ),
      style: TextStyle(
        color: AppColor.onBackground,
        fontFamily: "Avenir",
        fontWeight: FontWeight.w400,
        fontSize: 18.sp,
      ),
      maxLines: 1,
      autocorrect: false,
      obscureText: isPassword,
    ),
  );
}

// Input Email
Widget inputEmailEdit({
  TextEditingController? controller,
  TextInputType keyboardType = TextInputType.text,
  String? hintText,
  bool isPassword = false,
  double marginTop = 15,
  bool autofocus = false,
}) {
  return Container(
    height: 44.h,
    margin: EdgeInsets.only(top: marginTop.h),
    decoration: BoxDecoration(
      color: AppColor.background,
      borderRadius: Radii.k6pxRadius,
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(41, 0, 0, 0),
          offset: Offset(0, 1),
          blurRadius: 0,
        ),
      ],
    ),
    child: TextField(
      autofocus: autofocus,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 9),
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: AppColor.secondary,
        ),
      ),
      style: TextStyle(
        color: AppColor.onBackground,
        fontFamily: "Avenir",
        fontWeight: FontWeight.w400,
        fontSize: 18.sp,
      ),
      maxLines: 1,
      autocorrect: false,
      obscureText: isPassword,
    ),
  );
}
