import 'package:get/get.dart';

class DetailResponse {
  DetailResponse({
    String? method,
    bool? status,
    Detail? results,}){
    _method = method;
    _status = status;
    _results = results;
  }

  DetailResponse.fromJson(dynamic json) {
    _method = json['method'];
    _status = json['status'];
    _results = json['results'] != null ? Detail.fromJson(json['results']) : null;
  }
  String? _method;
  bool? _status;
  Detail? _results;

  String? get method => _method;
  bool? get status => _status;
  Detail? get results => _results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['method'] = _method;
    map['status'] = _status;
    if (_results != null) {
      map['results'] = _results?.toJson();
    }
    return map;
  }

}

class Detail {
  Detail({
      String? title, 
      String? thumb, 
      String? servings, 
      String? times, 
      String? dificulty, 
      Author? author, 
      String? desc, 
      List<NeedItem>? needItem, 
      List<String>? ingredient, 
      List<String>? step,}){
    _title = title;
    _thumb = thumb;
    _servings = servings;
    _times = times;
    _dificulty = dificulty;
    _author = author;
    _desc = desc;
    _needItem = needItem;
    _ingredient = ingredient;
    _step = step;
}

  Detail.fromJson(dynamic json) {
    _title = json['title'];
    _thumb = json['thumb'];
    _servings = json['servings'];
    _times = json['times'];
    _dificulty = json['dificulty'];
    _author = json['author'] != null ? Author.fromJson(json['author']) : null;
    _desc = json['desc'];
    if (json['needItem'] != null) {
      _needItem = [];
      json['needItem'].forEach((v) {
        _needItem?.add(NeedItem.fromJson(v));
      });
    }
    _ingredient = json['ingredient'] != null ? json['ingredient'].cast<String>() : [];
    if (json['step'] != null) {
      _step= [];
      json['step'].cast<String>().forEach((v) {
        var it = v.substring(2);
        if(it != "") _step?.add(it);
      });
    }
  }
  String? _title;
  String? _thumb;
  String? _servings;
  String? _times;
  String? _dificulty;
  Author? _author;
  String? _desc;
  List<NeedItem>? _needItem;
  List<String>? _ingredient;
  List<String>? _step;

  String? get title => _title;
  String? get thumb => _thumb;
  String? get servings => _servings;
  String? get times => _times;
  String? get dificulty => _dificulty;
  Author? get author => _author;
  String? get desc => _desc;
  List<NeedItem>? get needItem => _needItem;
  List<String>? get ingredient => _ingredient;
  List<String>? get step => _step;

  var _isFavorit = false.obs;
  set isFavorit(value) => _isFavorit.value = value;
  bool get isFavorit => _isFavorit.value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['thumb'] = _thumb;
    map['servings'] = _servings;
    map['times'] = _times;
    map['dificulty'] = _dificulty;
    if (_author != null) {
      map['author'] = _author?.toJson();
    }
    map['desc'] = _desc;
    if (_needItem != null) {
      map['needItem'] = _needItem?.map((v) => v.toJson()).toList();
    }
    map['ingredient'] = _ingredient;
    map['step'] = _step;
    return map;
  }

}

class NeedItem {
  NeedItem({
      String? itemName, 
      String? thumbItem,}){
    _itemName = itemName;
    _thumbItem = thumbItem;
}

  NeedItem.fromJson(dynamic json) {
    _itemName = json['item_name'];
    _thumbItem = json['thumb_item'];
  }
  String? _itemName;
  String? _thumbItem;

  String? get itemName => _itemName;
  String? get thumbItem => _thumbItem;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['item_name'] = _itemName;
    map['thumb_item'] = _thumbItem;
    return map;
  }

}

class Author {
  Author({
      String? user, 
      String? datePublished,}){
    _user = user;
    _datePublished = datePublished;
}

  Author.fromJson(dynamic json) {
    _user = json['user'];
    _datePublished = json['datePublished'];
  }
  String? _user;
  String? _datePublished;

  String? get user => _user;
  String? get datePublished => _datePublished;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = _user;
    map['datePublished'] = _datePublished;
    return map;
  }

}