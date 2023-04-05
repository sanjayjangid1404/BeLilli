/// error : false
/// message : "Acitivity history list"
/// data : {"total":10,"acitivity":[{"redeem_date":"2023-03-10","business_name":"Pizza Palace","offer_name":"Summer Clearance Sale"},{"redeem_date":"2023-03-10","business_name":"Adventure Co.","offer_name":"Buy One Get One Free"},{"redeem_date":"2023-03-10","business_name":"Adventure Co.","offer_name":"Buy One Get One Free"},{"redeem_date":"2023-03-09","business_name":"Adventure Co.","offer_name":"Buy One Get One Free"},{"redeem_date":"2023-03-09","business_name":"Adventure Co.","offer_name":"Buy One Get One Free"},{"redeem_date":"2023-03-09","business_name":"Adventure Co.","offer_name":"Buy One Get One Free"},{"redeem_date":"2023-03-09","business_name":"Adventure Co.","offer_name":"Buy One Get One Free"},{"redeem_date":"2023-03-09","business_name":"Adventure Co.","offer_name":"Buy One Get One Free"},{"redeem_date":"2023-03-09","business_name":"Adventure Co.","offer_name":"Buy One Get One Free"},{"redeem_date":"2023-03-09","business_name":"Pizza Palace","offer_name":"Summer Clearance Sale"}]}

class GetActivityResponse {
  GetActivityResponse({
      bool? error, 
      String? message, 
      Data? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetActivityResponse.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  Data? _data;
GetActivityResponse copyWith({  bool? error,
  String? message,
  Data? data,
}) => GetActivityResponse(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// total : 10
/// acitivity : [{"redeem_date":"2023-03-10","business_name":"Pizza Palace","offer_name":"Summer Clearance Sale"},{"redeem_date":"2023-03-10","business_name":"Adventure Co.","offer_name":"Buy One Get One Free"},{"redeem_date":"2023-03-10","business_name":"Adventure Co.","offer_name":"Buy One Get One Free"},{"redeem_date":"2023-03-09","business_name":"Adventure Co.","offer_name":"Buy One Get One Free"},{"redeem_date":"2023-03-09","business_name":"Adventure Co.","offer_name":"Buy One Get One Free"},{"redeem_date":"2023-03-09","business_name":"Adventure Co.","offer_name":"Buy One Get One Free"},{"redeem_date":"2023-03-09","business_name":"Adventure Co.","offer_name":"Buy One Get One Free"},{"redeem_date":"2023-03-09","business_name":"Adventure Co.","offer_name":"Buy One Get One Free"},{"redeem_date":"2023-03-09","business_name":"Adventure Co.","offer_name":"Buy One Get One Free"},{"redeem_date":"2023-03-09","business_name":"Pizza Palace","offer_name":"Summer Clearance Sale"}]

class Data {
  Data({
      num? total, 
      List<Acitivity>? acitivity,}){
    _total = total;
    _acitivity = acitivity;
}

  Data.fromJson(dynamic json) {
    _total = json['total'];
    if (json['acitivity'] != null) {
      _acitivity = [];
      json['acitivity'].forEach((v) {
        _acitivity?.add(Acitivity.fromJson(v));
      });
    }
  }
  num? _total;
  List<Acitivity>? _acitivity;
Data copyWith({  num? total,
  List<Acitivity>? acitivity,
}) => Data(  total: total ?? _total,
  acitivity: acitivity ?? _acitivity,
);
  num? get total => _total;
  List<Acitivity>? get acitivity => _acitivity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    if (_acitivity != null) {
      map['acitivity'] = _acitivity?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// redeem_date : "2023-03-10"
/// business_name : "Pizza Palace"
/// offer_name : "Summer Clearance Sale"

class Acitivity {
  Acitivity({
      String? redeemDate, 
      String? businessName, 
      String? offerName,}){
    _redeemDate = redeemDate;
    _businessName = businessName;
    _offerName = offerName;
}

  Acitivity.fromJson(dynamic json) {
    _redeemDate = json['redeem_date'];
    _businessName = json['business_name'];
    _offerName = json['offer_name'];
  }
  String? _redeemDate;
  String? _businessName;
  String? _offerName;
Acitivity copyWith({  String? redeemDate,
  String? businessName,
  String? offerName,
}) => Acitivity(  redeemDate: redeemDate ?? _redeemDate,
  businessName: businessName ?? _businessName,
  offerName: offerName ?? _offerName,
);
  String? get redeemDate => _redeemDate;
  String? get businessName => _businessName;
  String? get offerName => _offerName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['redeem_date'] = _redeemDate;
    map['business_name'] = _businessName;
    map['offer_name'] = _offerName;
    return map;
  }

}