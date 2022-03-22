import 'package:foods_yodeput/common/utils/utils.dart';
import 'package:foods_yodeput/model/food.dart';

class FoodsApi {
  Future getFoods() async {
    return await HttpUtil().get(
      '/foods',
    );
  }
}
