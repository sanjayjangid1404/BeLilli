/// error : false
/// message : "Category List"
/// data : [{"id":"1","name":"Coffee","banner":"/uploads/category_banners/Food_and_drink_banner.jpg","sort_order":"1","visible":"1"},{"id":"2","name":"Restaurant","banner":"/uploads/category_banners/Food_and_drink_banner.jpg","sort_order":"2","visible":"1"},{"id":"3","name":"Activities","banner":"/uploads/category_banners/Leisure_banner.jpg","sort_order":"3","visible":"1"},{"id":"4","name":"Gifts","banner":"/uploads/category_banners/health_and_fitness_banner.jpg","sort_order":"4","visible":"1"},{"id":"5","name":"Health & Beauty","banner":"/uploads/category_banners/Hair_and_beauty_banner.jpg","sort_order":"5","visible":"1"},{"id":"6","name":"Technology","banner":"/uploads/category_banners/online_businesses_banner.jpg","sort_order":"6","visible":"1"},{"id":"7","name":"Clothes","banner":"/uploads/category_banners/shopping2.jpg","sort_order":"7","visible":"1"},{"id":"8","name":"Kids & Family","banner":"/uploads/category_banners/Kids_banner.jpg","sort_order":"8","visible":"1"}]

class CategoryListResponse {
  CategoryListResponse({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  CategoryListResponse.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
CategoryListResponse copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => CategoryListResponse(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// name : "Coffee"
/// banner : "/uploads/category_banners/Food_and_drink_banner.jpg"
/// sort_order : "1"
/// visible : "1"

class Data {
  Data({
      String? id, 
      String? name, 
      String? banner, 
      String? sortOrder, 
      String? visible,}){
    _id = id;
    _name = name;
    _banner = banner;
    _sortOrder = sortOrder;
    _visible = visible;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _banner = json['banner'];
    _sortOrder = json['sort_order'];
    _visible = json['visible'];
  }
  String? _id;
  String? _name;
  String? _banner;
  String? _sortOrder;
  String? _visible;
Data copyWith({  String? id,
  String? name,
  String? banner,
  String? sortOrder,
  String? visible,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  banner: banner ?? _banner,
  sortOrder: sortOrder ?? _sortOrder,
  visible: visible ?? _visible,
);
  String? get id => _id;
  String? get name => _name;
  String? get banner => _banner;
  String? get sortOrder => _sortOrder;
  String? get visible => _visible;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['banner'] = _banner;
    map['sort_order'] = _sortOrder;
    map['visible'] = _visible;
    return map;
  }

}