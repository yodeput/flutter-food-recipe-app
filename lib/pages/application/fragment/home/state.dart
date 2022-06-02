import 'package:foods_yodeput/data/model/model.dart';
import 'package:get/get.dart';

class HomeState {
  RxBool isLoading = false.obs;

  RxInt page = 0.obs;

  RxList<Recipe> dataList = <Recipe>[].obs;
  RxList<Recipe> favList = <Recipe>[].obs;
}
