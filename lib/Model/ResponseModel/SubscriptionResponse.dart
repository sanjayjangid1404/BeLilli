/// error : false
/// message : "Subscription Added"
/// data : {"id":"1","first_name":"demo","last_name":"testing","email":"demo@gmail.com","password":"$2y$10$Qf7lTvFLDmyO51TyDlw.xO8jZ9IFpANybwvWH4fHhR6VZP7R323H2","device_type":"Android","device_id":"","lat":null,"lang":null,"status":"1","created":"2023-08-23 10:17:35","updated":"2023-08-23 11:32:53","start_date":"2023-08-23 12:19:21","end_date":"2023-09-23 12:19:21"}

class SubscriptionResponse {
  SubscriptionResponse({
      bool? error, 
      String? message, 
      Data? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  SubscriptionResponse.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  Data? _data;
SubscriptionResponse copyWith({  bool? error,
  String? message,
  Data? data,
}) => SubscriptionResponse(  error: error ?? _error,
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

/// id : "1"
/// first_name : "demo"
/// last_name : "testing"
/// email : "demo@gmail.com"
/// password : "$2y$10$Qf7lTvFLDmyO51TyDlw.xO8jZ9IFpANybwvWH4fHhR6VZP7R323H2"
/// device_type : "Android"
/// device_id : ""
/// lat : null
/// lang : null
/// status : "1"
/// created : "2023-08-23 10:17:35"
/// updated : "2023-08-23 11:32:53"
/// start_date : "2023-08-23 12:19:21"
/// end_date : "2023-09-23 12:19:21"

class Data {
  Data({
      String? id, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? password, 
      String? deviceType, 
      String? deviceId, 
      dynamic lat, 
      dynamic lang, 
      String? status, 
      String? created, 
      String? updated, 
      String? startDate, 
      String? endDate,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _password = password;
    _deviceType = deviceType;
    _deviceId = deviceId;
    _lat = lat;
    _lang = lang;
    _status = status;
    _created = created;
    _updated = updated;
    _startDate = startDate;
    _endDate = endDate;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _password = json['password'];
    _deviceType = json['device_type'];
    _deviceId = json['device_id'];
    _lat = json['lat'];
    _lang = json['lang'];
    _status = json['status'];
    _created = json['created'];
    _updated = json['updated'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
  }
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _password;
  String? _deviceType;
  String? _deviceId;
  dynamic _lat;
  dynamic _lang;
  String? _status;
  String? _created;
  String? _updated;
  String? _startDate;
  String? _endDate;
Data copyWith({  String? id,
  String? firstName,
  String? lastName,
  String? email,
  String? password,
  String? deviceType,
  String? deviceId,
  dynamic lat,
  dynamic lang,
  String? status,
  String? created,
  String? updated,
  String? startDate,
  String? endDate,
}) => Data(  id: id ?? _id,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  password: password ?? _password,
  deviceType: deviceType ?? _deviceType,
  deviceId: deviceId ?? _deviceId,
  lat: lat ?? _lat,
  lang: lang ?? _lang,
  status: status ?? _status,
  created: created ?? _created,
  updated: updated ?? _updated,
  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
);
  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get password => _password;
  String? get deviceType => _deviceType;
  String? get deviceId => _deviceId;
  dynamic get lat => _lat;
  dynamic get lang => _lang;
  String? get status => _status;
  String? get created => _created;
  String? get updated => _updated;
  String? get startDate => _startDate;
  String? get endDate => _endDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['password'] = _password;
    map['device_type'] = _deviceType;
    map['device_id'] = _deviceId;
    map['lat'] = _lat;
    map['lang'] = _lang;
    map['status'] = _status;
    map['created'] = _created;
    map['updated'] = _updated;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    return map;
  }

}