import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  static StorageService get to => Get.find();
  late final GetStorage _box;

  Future<StorageService> init() async {
    await GetStorage.init();
    _box = GetStorage();

    return this;
  }

  Future<bool> setString(String key, String value) async {
    try {
      await _box.write(key, value);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> setBool(String key, bool value) async {
    try {
      await _box.write(key, value);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> setList(String key, List<String> value) async {
    try {
      await _box.write(key, value);
      return true;
    } catch (error) {
      return false;
    }
  }

  String getString(String key) {
    return _box.read(key) ?? '';
  }

  bool getBool(String key) {
    return _box.read(key) ?? false;
  }

  List<String> getList(String key) {
    return _box.read(key) ?? [];
  }

  Future<bool> remove(String key) async {
    try {
      await _box.remove(key);
      return true;
    } catch (error) {
      return false;
    }
  }
}
