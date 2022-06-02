import 'package:get/get.dart';

class RecipeResponse {
  RecipeResponse({
    bool? status,
    String? method,
    List<Recipe>? results}) {
    _status = status;
    _method = method;
    _results = results;
  }

  RecipeResponse.fromJson(dynamic json) {
    _status = json['status'];
    _method = json['method'];
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(Recipe.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _method;
  List<Recipe>? _results;

  bool? get status => _status;
  String? get method => _method;
  List<Recipe>? get results => _results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['method'] = _method;
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Recipe {
  Recipe({
      String? dificulty, 
      String? title, 
      String? thumb, 
      String? key, 
      String? times, 
      String? portion,
      bool isFavorit = false,
  }){
    _dificulty = dificulty;
    _title = title;
    _thumb = thumb;
    _key = key;
    _times = times;
    _portion = portion;
    _isFavorit.value = isFavorit;
}

  Recipe.fromJson(dynamic json) {
    _dificulty = json['dificulty'];
    _title = json['title'];
    if(json['title'] == null) {
      var t = json['key'].toString().replaceAll("-", " ");
      _title = t.split(" ").map((str) => str.capitalize).join(" ");
    }
    _thumb = json['thumb'];
    _key = json['key'];
    _times = json['times'];
    _portion = json['portion'];
  }
  String? _dificulty;
  String? _title;
  String? _thumb;
  String? _key;
  String? _times;
  String? _portion;



  String? get dificulty => _dificulty;
  String? get title => _title;
  String? get thumb => _thumb;
  String? get key => _key;
  String? get times => _times;
  String? get portion => _portion;

  var _isFavorit = false.obs;
  set isFavorit(value) => _isFavorit.value = value;
  bool get isFavorit => _isFavorit.value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dificulty'] = _dificulty;
    map['title'] = _title;
    map['thumb'] = _thumb;
    map['key'] = _key;
    map['times'] = _times;
    map['portion'] = _portion;
    return map;
  }

}