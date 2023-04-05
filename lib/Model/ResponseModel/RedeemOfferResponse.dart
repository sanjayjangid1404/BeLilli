/// error : false
/// message : "Offer Redeemed"
/// data : {"id":"2","category_id":"2","business_name":"Adventure Co.","description":"We offer exciting outdoor activities such as hiking, kayaking, and more!","image":"/uploads/outdooractivites.jpg","contact_first_name":"Jane","contact_last_name":"Doe","email":"jane@adventureco.com","password":"password","hash":"hash","address1":"456 Oak St","address2":"","town":"Somewhere","county":"Somecounty","postcode":"67890","lat":"44.5678","lng":"-88.8765","website":"http://www.adventureco.com","featured":"1","active_cms":"1","active_app":"1","created":"2023-02-27 12:00:00","updated":"2023-02-27 07:06:18"}

class RedeemOfferResponse {
  RedeemOfferResponse({
      bool? error, 
      String? message, 
      Data? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  RedeemOfferResponse.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  Data? _data;
RedeemOfferResponse copyWith({  bool? error,
  String? message,
  Data? data,
}) => RedeemOfferResponse(  error: error ?? _error,
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

/// id : "2"
/// category_id : "2"
/// business_name : "Adventure Co."
/// description : "We offer exciting outdoor activities such as hiking, kayaking, and more!"
/// image : "/uploads/outdooractivites.jpg"
/// contact_first_name : "Jane"
/// contact_last_name : "Doe"
/// email : "jane@adventureco.com"
/// password : "password"
/// hash : "hash"
/// address1 : "456 Oak St"
/// address2 : ""
/// town : "Somewhere"
/// county : "Somecounty"
/// postcode : "67890"
/// lat : "44.5678"
/// lng : "-88.8765"
/// website : "http://www.adventureco.com"
/// featured : "1"
/// active_cms : "1"
/// active_app : "1"
/// created : "2023-02-27 12:00:00"
/// updated : "2023-02-27 07:06:18"

class Data {
  Data({
      String? id, 
      String? categoryId, 
      String? businessName, 
      String? description, 
      String? image, 
      String? contactFirstName, 
      String? contactLastName, 
      String? email, 
      String? password, 
      String? hash, 
      String? address1, 
      String? address2, 
      String? town, 
      String? county, 
      String? postcode, 
      String? lat, 
      String? lng, 
      String? website, 
      String? featured, 
      String? activeCms, 
      String? activeApp, 
      String? created, 
      String? updated,}){
    _id = id;
    _categoryId = categoryId;
    _businessName = businessName;
    _description = description;
    _image = image;
    _contactFirstName = contactFirstName;
    _contactLastName = contactLastName;
    _email = email;
    _password = password;
    _hash = hash;
    _address1 = address1;
    _address2 = address2;
    _town = town;
    _county = county;
    _postcode = postcode;
    _lat = lat;
    _lng = lng;
    _website = website;
    _featured = featured;
    _activeCms = activeCms;
    _activeApp = activeApp;
    _created = created;
    _updated = updated;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _businessName = json['business_name'];
    _description = json['description'];
    _image = json['image'];
    _contactFirstName = json['contact_first_name'];
    _contactLastName = json['contact_last_name'];
    _email = json['email'];
    _password = json['password'];
    _hash = json['hash'];
    _address1 = json['address1'];
    _address2 = json['address2'];
    _town = json['town'];
    _county = json['county'];
    _postcode = json['postcode'];
    _lat = json['lat'];
    _lng = json['lng'];
    _website = json['website'];
    _featured = json['featured'];
    _activeCms = json['active_cms'];
    _activeApp = json['active_app'];
    _created = json['created'];
    _updated = json['updated'];
  }
  String? _id;
  String? _categoryId;
  String? _businessName;
  String? _description;
  String? _image;
  String? _contactFirstName;
  String? _contactLastName;
  String? _email;
  String? _password;
  String? _hash;
  String? _address1;
  String? _address2;
  String? _town;
  String? _county;
  String? _postcode;
  String? _lat;
  String? _lng;
  String? _website;
  String? _featured;
  String? _activeCms;
  String? _activeApp;
  String? _created;
  String? _updated;
Data copyWith({  String? id,
  String? categoryId,
  String? businessName,
  String? description,
  String? image,
  String? contactFirstName,
  String? contactLastName,
  String? email,
  String? password,
  String? hash,
  String? address1,
  String? address2,
  String? town,
  String? county,
  String? postcode,
  String? lat,
  String? lng,
  String? website,
  String? featured,
  String? activeCms,
  String? activeApp,
  String? created,
  String? updated,
}) => Data(  id: id ?? _id,
  categoryId: categoryId ?? _categoryId,
  businessName: businessName ?? _businessName,
  description: description ?? _description,
  image: image ?? _image,
  contactFirstName: contactFirstName ?? _contactFirstName,
  contactLastName: contactLastName ?? _contactLastName,
  email: email ?? _email,
  password: password ?? _password,
  hash: hash ?? _hash,
  address1: address1 ?? _address1,
  address2: address2 ?? _address2,
  town: town ?? _town,
  county: county ?? _county,
  postcode: postcode ?? _postcode,
  lat: lat ?? _lat,
  lng: lng ?? _lng,
  website: website ?? _website,
  featured: featured ?? _featured,
  activeCms: activeCms ?? _activeCms,
  activeApp: activeApp ?? _activeApp,
  created: created ?? _created,
  updated: updated ?? _updated,
);
  String? get id => _id;
  String? get categoryId => _categoryId;
  String? get businessName => _businessName;
  String? get description => _description;
  String? get image => _image;
  String? get contactFirstName => _contactFirstName;
  String? get contactLastName => _contactLastName;
  String? get email => _email;
  String? get password => _password;
  String? get hash => _hash;
  String? get address1 => _address1;
  String? get address2 => _address2;
  String? get town => _town;
  String? get county => _county;
  String? get postcode => _postcode;
  String? get lat => _lat;
  String? get lng => _lng;
  String? get website => _website;
  String? get featured => _featured;
  String? get activeCms => _activeCms;
  String? get activeApp => _activeApp;
  String? get created => _created;
  String? get updated => _updated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['business_name'] = _businessName;
    map['description'] = _description;
    map['image'] = _image;
    map['contact_first_name'] = _contactFirstName;
    map['contact_last_name'] = _contactLastName;
    map['email'] = _email;
    map['password'] = _password;
    map['hash'] = _hash;
    map['address1'] = _address1;
    map['address2'] = _address2;
    map['town'] = _town;
    map['county'] = _county;
    map['postcode'] = _postcode;
    map['lat'] = _lat;
    map['lng'] = _lng;
    map['website'] = _website;
    map['featured'] = _featured;
    map['active_cms'] = _activeCms;
    map['active_app'] = _activeApp;
    map['created'] = _created;
    map['updated'] = _updated;
    return map;
  }

}