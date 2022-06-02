import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foods_yodeput/common/routes/routes.dart';
import 'package:foods_yodeput/common/style/style.dart';
import 'package:foods_yodeput/common/widgets/widgets.dart';
import 'package:foods_yodeput/data/model/model.dart';
import 'package:get/get.dart';

import 'index.dart';

class FavoritePage extends GetView<FavoriteController> {
  @override
  Widget build(BuildContext context) {
    AppTheme.setStatusBarColor(color: AppColor.background);
    return Obx(() {
      return controller.state.isLoading.isTrue
          ? loadingWidget()
          : controller.state.favList.length > 0
              ? _buildListview()
              : noDataWidget(message: "Add your favorite Recipe");
    });
  }

  Widget _buildListview() {
    return CustomScrollView(
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
    );
  }

  Widget _buildItemView(Recipe item,  int index) {
    var size = controller.state.favList.length;
    return Padding(
      padding: EdgeInsets.only(bottom: index+1 == size ? 0 : 5.h),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        elevation: 5.0,
        child: InkWell(
          onTap: () async {
            final result = await Get.toNamed(AppRoutes.DETAIL, arguments: item);
            controller.getFavorite();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              netImageCached(
                item.thumb ?? "",
                width: 100.w,
                height: 100.h,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(
                            color: AppColor.onBackground, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 0,
                        height: 8,
                      ),
                      Row(
                        children: [
                          buildExtraDetailRow(FontAwesomeIcons.hourglass, item.times ?? "", color: AppColor.secondary),
                          SizedBox(
                            width: 15,
                            height: 5,
                          ),
                          buildExtraDetailRow(FontAwesomeIcons.bowlFood, item.portion ?? "", color: AppColor.secondary),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
