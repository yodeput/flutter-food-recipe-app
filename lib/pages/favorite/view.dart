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
            return SliverList(
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            netImageCached(
              item.image ?? "",
              width: 100.w,
              height: 100.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
                    color: AppColor.onBackground, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
