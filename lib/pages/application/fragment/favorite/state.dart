import 'package:foods_yodeput/data/model/model.dart';
import 'package:get/get.dart';

class FavoriteState {
  RxBool isLoading = false.obs;

  RxList<Recipe> favList = <Recipe>[].obs;
}
