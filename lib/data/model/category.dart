class CategoryResponse {
  CategoryResponse({
    bool? status,
    String? method,
    List<Category>? results}) {
    _status = status;
    _method = method;
    _results = results;
  }

  CategoryResponse.fromJson(dynamic json) {
    _status = json['status'];
    _method = json['method'];
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(Category.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _method;
  List<Category>? _results;

  bool? get status => _status;
  String? get method => _method;
  List<Category>? get results => _results;

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

class Category {
  Category({
      String? url, 
      String? category, 
      String? key,}){
    _url = url;
    _category = category;
    _key = key;
}

  Category.fromJson(dynamic json) {
    _url = json['url'];
    _category = json['category'];
    _key = json['key'];
  }
  String? _url;
  String? _category;
  String? _key;

  String? get url => _url;
  String? get category => _category;
  String? get key => _key;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['category'] = _category;
    map['key'] = _key;
    return map;
  }

}