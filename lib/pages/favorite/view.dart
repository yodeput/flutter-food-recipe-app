import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_yodeput/common/routes/routes.dart';
import 'package:foods_yodeput/common/style/style.dart';
import 'package:foods_yodeput/common/widgets/widgets.dart';
import 'package:foods_yodeput/model/food.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'index.dart';

class FavoritePage extends GetView<FavoriteController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.state.favList == null
          ? loadingWidget()
          : controller.state.favList.length > 0
              ? _buildListview()
              : noDataWidget(message: "Add your favorite Recipe");
    });
  }

  Widget _buildListview() {
    return SmartRefresher(
        enablePullUp: false,
        enablePullDown: true,
        controller: controller.refreshController,
        onRefresh: controller.refreshData,
        child: CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(
            vertical: 0.w,
            horizontal: 10.w,
          ),
          sliver: Obx(() {
            return SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _buildItemView(controller.state.favList[index], index);
                },
                childCount: controller.state.favList.length,
              ),
            );
          }),
        ),
      ],
    ),
    );
  }

  Widget _buildItemView(Food item, int index) {
    return Card(
      elevation: 16.0,
      child: InkWell(
        onTap: () async {
          final result = await Get.toNamed(AppRoutes.DETAIL, arguments: item);
          controller.refreshData();
        },
        child: Stack(
          children: [
            netImageCached(
              item.image ?? "",
              width: double.infinity.w,
              height: double.infinity.h,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    top: 30.h, bottom: 10.w, left: 10.w, right: 10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(6),
                        bottomRight: Radius.circular(6)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black87,
                      ],
                    )),
                child: Text(
                  item.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(
                      color: AppColor.onPrimary, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
