import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:foods_yodeput/common/constant/values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_yodeput/common/style/style.dart';
import 'package:foods_yodeput/common/utils/utils.dart';

Widget netImageCached(
  String url, {
  double width = 48,
  double height = 48,
  EdgeInsetsGeometry? margin,
  bool isRounded = true,
}) {
  return CachedNetworkImage(
    imageUrl: url,
    imageBuilder: (context, imageProvider) => Container(
      height: height.h,
      width: width.w,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: isRounded ? Radii.k6pxRadius : null,
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
          // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
        ),
      ),
    ),
    placeholder: (context, url) {
      return Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: AppColor.primary,
        ),
      );
    },
    errorWidget: (context, url, error) => Container(
        color: AppColor.primaryContainer,
        child: Center(
            child: Icon(
          Iconfont.image,
          size: 80.w,
        ))),
  );
}
