import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_yodeput/common/routes/routes.dart';
import 'package:foods_yodeput/common/style/style.dart';
import 'package:foods_yodeput/common/utils/utils.dart';
import 'package:foods_yodeput/common/widgets/widgets.dart';
import 'package:foods_yodeput/gen/assets.gen.dart';
import 'package:foods_yodeput/model/food.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'index.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var state = controller.state;
      return state.isLoading == true || controller.state.foodsList == null
          ? loadingWidget()
          : _buildListview();
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
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Obx(() {
                    return _buildItemView(
                        controller.state.foodsList[index], index);
                  });
                },
                childCount: controller.state.foodsList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemView(Food item, int index) {
    return Card(
      elevation: 16.0,
      child: InkWell(
        onTap: (){
          Get.toNamed(AppRoutes.DETAIL, arguments: item);
        },
        child: Stack(
          children: [
            netImageCached(
              item.image ?? "",
              width: double.infinity.w,
              height: double.infinity.h,
            ),
            Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(6),
                          bottomLeft: Radius.circular(6),),
                      color: Colors.white60
                  ),
                  child: Obx(() {
                    return InkWell(
                      onTap: () {
                        controller.setFavorit(item);
                      },
                      child: Icon(
                        Iconfont.fav,
                        size: 18.0,
                        color: item.isFavorit ? AppColor.dangerColor : AppColor
                            .secondary,
                      ),
                    );
                  }),
                )),
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
                    )
                ),
                child: Text(
                  item.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme
                      .of(Get.context!)
                      .textTheme
                      .titleSmall
                      ?.copyWith(
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
