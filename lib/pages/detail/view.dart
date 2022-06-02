import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_yodeput/common/style/style.dart';
import 'package:foods_yodeput/common/widgets/app.dart';
import 'package:foods_yodeput/common/widgets/widgets.dart';
import 'package:foods_yodeput/data/model/detail.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import 'index.dart';

class DetailPage extends GetView<DetailController> {
  DetailPage();

  @override
  Widget build(BuildContext context) {
    AppTheme.setStatusBarColor(color: Colors.transparent);
    return Scaffold(
      extendBodyBehindAppBar: true,
        body: Obx(() => controller.state.isLoading.value == false
            ? NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      backgroundColor: AppColor.primary,
                      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light),
                      expandedHeight: 200.0,
                      floating: false,
                      pinned: true,
                      elevation: 0,
                      snap: false,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: false,
                        titlePadding: EdgeInsets.only(
                            bottom: 10.w, left: 45.w, right: 45.w),
                        expandedTitleScale: 1.2,
                        title: Text(
                          controller.state.detail.title ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        background: Stack(
                          children: [
                            Obx(() {
                              return netImageCached(
                                  controller.state.detail.thumb ??
                                      controller.recipe.thumb,
                                  width: double.infinity.w,
                                  height: double.infinity.h,
                                  isRounded: false);
                            }),
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
                      leadingWidth: 55.w,
                      actions: [
                        Container(
                          width: 55.w,
                          child: Center(
                            child: InkWell(
                              onTap: controller.setFavorit,
                              child: Padding(
                                  padding: EdgeInsets.all(10.w),
                                  child: Obx(() {
                                    return FaIcon(
                                      controller.state.detail.isFavorit
                                          ? FontAwesomeIcons.solidHeart
                                          : FontAwesomeIcons.heart,
                                      color: controller.state.detail.isFavorit
                                          ? AppColor.dangerColor
                                          : AppColor.dangerColor,
                                    );
                                  })),
                            ),
                          ),
                        )
                      ],
                    ),
                  ];
                },
                body: Obx(() {
                  Detail data = controller.state.detail;
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0)),
                          ),
                          child: Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildExtraDetailRow(
                                    FontAwesomeIcons.hourglass, data.times ?? ""),
                                SizedBox(
                                  width: 15,
                                  height: 5,
                                ),
                                buildExtraDetailRow(
                                    FontAwesomeIcons.bowlFood, data.servings ?? ""),
                                SizedBox(
                                  width: 15,
                                  height: 5,
                                ),
                                buildExtraDetailRow(
                                    FontAwesomeIcons.boxesStacked, data.dificulty ?? ""),
                              ],
                            ),
                          ),
                        ),
                        _buildDescription(data.desc ?? ""),
                        _buildList(
                            "Bahan dan Bumbu", data.ingredient ?? <String>[]),
                        _buildListStep("Cara Memasak", data.step ?? <String>[]),
                      ],
                    ),
                  );
                }),
              )
            : loadingWidget()));
  }

  Widget _buildDescription(String desc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          color: AppColor.secondary,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          child: Text(
            "Deskripsi",
            style: Theme.of(Get.context!).textTheme.titleSmall!.copyWith(
                  color: AppColor.onSecondary,
                ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: ReadMoreText(
            desc,
            trimLines: 3,
            colorClickableText: AppColor.primary,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Show more',
            trimExpandedText: 'Show less',
            style: Theme.of(Get.context!)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColor.onBackground),
          ),
        )
      ],
    );
  }

  Widget _buildList(String title, List<String> dataList) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            color: AppColor.secondary,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
            child: Text(
              title,
              style: Theme.of(Get.context!).textTheme.titleSmall!.copyWith(
                    color: AppColor.onSecondary,
                  ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(5),
                itemCount: dataList.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var data = dataList[index];
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                    child: Row(
                      children: [
                        Text(
                          "●",
                          style:
                          Theme.of(Get.context!).textTheme.bodySmall!.copyWith(
                            color: AppColor.onBackground,
                          ),
                        ),
                        SizedBox.square(dimension: 3.w,),
                        Expanded(
                          child: Text(
                            data,
                            style:
                                Theme.of(Get.context!).textTheme.bodySmall!.copyWith(
                                      color: AppColor.onBackground,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          )
        ]);
  }

  Widget _buildListStep(String title, List<String> dataList) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            color: AppColor.secondary,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
            child: Text(
              title,
              style: Theme.of(Get.context!).textTheme.titleSmall!.copyWith(
                color: AppColor.onSecondary,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(5),
                itemCount: dataList.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var data = dataList[index];
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 1.8.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "●",
                          style:
                          Theme.of(Get.context!).textTheme.bodySmall!.copyWith(
                            color: AppColor.onBackground,
                          ),
                        ),
                        SizedBox.square(dimension: 3.w,),
                        Expanded(
                          child: Text(
                            data,
                            style:
                            Theme.of(Get.context!).textTheme.bodySmall!.copyWith(
                              color: AppColor.onBackground,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          )
        ]);
  }
}
