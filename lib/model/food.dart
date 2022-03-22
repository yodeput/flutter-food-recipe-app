import 'package:get/get.dart';
class Food {
  Food({
      String? name, 
      String? image, 
      String? desc,
      bool isFavorit = false,
  }){
    _name = name;
    _image = image;
    _desc = desc;
    _isFavorit.value = isFavorit;
}

  Food.fromJson(dynamic json) {
    _name = json['name'];
    _image = json['image'];
    _desc = json['desc'];
  }
  String? _name;
  String? _image;
  String? _desc;
  var _isFavorit = false.obs;

  String? get name => _name;
  String? get image => _image;
  String? get desc => _desc;

  set isFavorit(value) => _isFavorit.value = value;
  bool get isFavorit => _isFavorit.value;

  String get descSplitted => _desc!.replaceAll("/n", "/n ✹ ");

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['image'] = _image;
    map['desc'] = _desc;
    return map;
  }

}