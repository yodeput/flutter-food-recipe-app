import 'package:foods_yodeput/common/utils/utils.dart';

class RecipeApi {
  Future fetchList(int page) async {
    return await HttpUtil().get(
      '/recipes/${page}',
    );
  }

  Future fetchRecipe(String key) async {
    return await HttpUtil().get(
      '/recipe/${key}',
    );
  }
}
