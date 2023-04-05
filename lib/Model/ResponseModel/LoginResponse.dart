/// error : false
/// message : "User detail"
/// data : {"id":"4","first_name":"","last_name":"","email":"","password":"$2y$10$oJCQznwNdk7XRJj9/mNU8Ob8OSt/kcimhiZrpkTcyxE7deVzXBzm6","device_type":"","device_id":"","lat":null,"lang":null,"status":"1","created":"2023-02-20 06:44:32","updated":null,"start_date":null,"end_date":null}

class LoginResponse {
  LoginResponse({
      bool? error, 
      String? message, 
      Data? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  LoginResponse.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  Data? _data;
LoginResponse copyWith({  bool? error,
  String? message,
  Data? data,
}) => LoginResponse(  error: error ?? _error,
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

/// id : "4"
/// first_name : ""
/// last_name : ""
/// email : ""
/// password : "$2y$10$oJCQznwNdk7XRJj9/mNU8Ob8OSt/kcimhiZrpkTcyxE7deVzXBzm6"
/// device_type : ""
/// device_id : ""
/// lat : null
/// lang : null
/// status : "1"
/// created : "2023-02-20 06:44:32"
/// updated : null
/// start_date : null
/// end_date : null

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
      dynamic updated, 
      dynamic startDate, 
      dynamic endDate,}){
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
  dynamic _updated;
  dynamic _startDate;
  dynamic _endDate;
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
  dynamic updated,
  dynamic startDate,
  dynamic endDate,
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
  dynamic get updated => _updated;
  dynamic get startDate => _startDate;
  dynamic get endDate => _endDate;

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