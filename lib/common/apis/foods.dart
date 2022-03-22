import 'package:foods_yodeput/common/utils/utils.dart';
import 'package:foods_yodeput/model/food.dart';

class FoodsApi {

  static getFoods({
     Function(List<Food> data)? onSuccess,
     Function(bool data)? loading,
     Function(dynamic error)? onError,
  }) async {
      loading!(true);
      HttpUtil().get(
        '/foods',
      ).then((res) {
        var data = List<Food>.from(res.map((v) => Food.fromJson(v)));
        onSuccess!(data);
      }).catchError((error){
        onError!(error);
      }).whenComplete(() => loading(false));
  }

}