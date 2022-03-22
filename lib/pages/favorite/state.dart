import 'package:foods_yodeput/model/food.dart';
import 'package:get/get.dart';

class FavoriteState {
  var _favList = Rx<List<Food>?>(null);
  set favList(value) => _favList.value = value;
  get favList => _favList.value;
}
