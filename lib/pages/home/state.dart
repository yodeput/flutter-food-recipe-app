import 'package:foods_yodeput/model/food.dart';
import 'package:get/get.dart';

class HomeState {
  var _isLoading = false.obs;
  set isLoading(data) => _isLoading.value = data;
  get isLoading => _isLoading.value;

  var _foodsList = Rx<List<Food>?>(null);
  set foodsList(value) => _foodsList.value = value;
  get foodsList => _foodsList.value;


  var _favList = Rx<List<Food>?>(null);
  set favList(value) => _favList.value = value;
  get favList => _favList.value;
}
