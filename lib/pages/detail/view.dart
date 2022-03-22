import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foods_yodeput/common/constant/values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_yodeput/common/style/style.dart';
import 'package:foods_yodeput/common/utils/utils.dart';
import 'package:foods_yodeput/common/widgets/app.dart';
import 'package:foods_yodeput/common/widgets/widgets.dart';
import 'package:foods_yodeput/gen/assets.gen.dart';
import 'package:get/get.dart';

import 'index.dart';

class DetailPage extends GetView<DetailController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.state.food != null
          ? Scaffold(
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      backgroundColor: AppColor.primary,
                      expandedHeight: 240.0,
                      floating: true,
                      pinned: true,
                      actions: [
                        Obx(() {
                          return Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: Row(
                              children: [
                                InkWell(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6.0)),
                                  onTap: () {
                                    controller.setFavorit();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Icon(
                                      Iconfont.fav,
                                      size: 24.0,
                                      color: controller.state.food.isFavorit
                                          ? AppColor.dangerColor
                                          : AppColor.onPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: false,
                        expandedTitleScale: 1.3,
                        title: Text(
                          controller.state.food.name ?? "",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        background: Stack(
                          children: [
                            netImageCached(controller.state.food.image,
                                width: double.infinity.w,
                                height: double.infinity.h,
                                isRounded: false),
                            Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black87,
                                ],
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: Obx(() {
                  return _buildDescription(controller.state.food.descSplitted ?? "");
                }),
              ),
            )
          : loadingWidget();
    });
  }

  Widget _buildDescription(String desc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          color: AppColor.secondary,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          child: Text(
            "Ingredients",
            style: Theme.of(Get.context!).textTheme.titleSmall!.copyWith(
                  color: AppColor.onSecondary,
                ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Text(
              "${desc}",
              textAlign: TextAlign.start,
              style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
                    color: AppColor.onBackground,
                height: 1.5.h
                  ),
            ),
          ),
        )
      ],
    );
  }
}
