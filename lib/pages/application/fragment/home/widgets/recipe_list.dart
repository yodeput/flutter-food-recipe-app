import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foods_yodeput/common/routes/routes.dart';
import 'package:foods_yodeput/common/style/style.dart';
import 'package:foods_yodeput/common/widgets/widgets.dart';
import 'package:foods_yodeput/data/model/recipe.dart';
import 'package:foods_yodeput/pages/application/fragment/home/index.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RecipeList extends StatelessWidget {
  RecipeList({Key? key}) : super(key: key);

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return _buildListview();
  }

  Widget _buildListview() {
    return Obx(() {
      return SmartRefresher(
        enablePullUp: true,
        enablePullDown: true,
        controller: controller.refreshController,
        onRefresh: controller.refreshData,
        onLoading: controller.loadData,
        header: WaterDropHeader(
          waterDropColor: AppColor.primary,
        ),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("Pull up to load more");
            } else if (mode == LoadStatus.loading) {
              body = loadingWidget(height: 40, width: 40);
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("Release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 10.w,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Obx(() {
                      return recipeItem(
                          controller.state.dataList[index], index);
                    });
                  },
                  childCount: controller.state.dataList.length,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget recipeItem(Recipe item, int index) {
    var size = controller.state.dataList.length;
    return Padding(
      padding: EdgeInsets.only(bottom: index + 1 == size ? 0 : 5.h),
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Stack(
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.DETAIL, arguments: item);
              },
              child: Column(
                children: [
                  Stack(
                    children: [
                      netImageCached(
                        item.thumb ?? "",
                        width: double.infinity.w,
                        height: 100.h,
                      ),
                      Container(
                        width: double.infinity.w,
                        height: 100.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black54,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8.w, horizontal: 10.w),
                        child: Text(
                          item.title ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(Get.context!).textTheme.caption?.copyWith(
                              color: AppColor.onBackground,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildExtraDetailRow(
                                  FontAwesomeIcons.hourglass, item.times!),
                              SizedBox(
                                width: 15,
                                height: 5,
                              ),
                              buildExtraDetailRow(
                                  FontAwesomeIcons.bowlFood, item.portion!),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Obx(() {
                  return InkWell(
                    onTap: () {
                      controller.setFavorit(item);
                    },
                    child: FaIcon(
                      item.isFavorit ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                      size: 20.0,
                      color: item.isFavorit
                          ? AppColor.dangerColor
                          : AppColor.primary,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
