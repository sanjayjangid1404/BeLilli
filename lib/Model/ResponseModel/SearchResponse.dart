/// error : false
/// message : "Business List"
/// data : ["Adventure Co.","Adventure Outfitters"]

class SearchResponse {
  SearchResponse({
      bool? error, 
      String? message, 
      List<String>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  SearchResponse.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? json['data'].cast<String>() : [];
  }
  bool? _error;
  String? _message;
  List<String>? _data;
SearchResponse copyWith({  bool? error,
  String? message,
  List<String>? data,
}) => SearchResponse(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<String>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    map['data'] = _data;
    return map;
  }

}