import 'package:foods_yodeput/data/model/detail.dart';
import 'package:foods_yodeput/data/model/recipe.dart';
import 'package:get/get.dart';

class DetailState {
  RxBool isLoading = false.obs;

  var _detail = Rx<Detail>(Detail());
  set detail(value) => _detail.value = value;
  get detail => _detail.value;

  List<Recipe> favList = <Recipe>[].obs;
}
