/// error : false
/// message : "Business List"
/// data : [{"id":"2","category_id":"2","business_name":"Adventure Co.","description":"We offer exciting outdoor activities such as hiking, kayaking, and more!","image":"/uploads/outdooractivites.jpg","contact_first_name":"Jane","contact_last_name":"Doe","email":"jane@adventureco.com","password":"password","hash":"hash","address1":"456 Oak St","address2":"","town":"Somewhere","county":"Somecounty","postcode":"67890","lat":"44.5678","lng":"-88.8765","website":"http://www.adventureco.com","featured":"1","active_cms":"1","active_app":"1","created":"2023-02-27 12:00:00","updated":"2023-02-27 07:06:18","category_name":"Activities","member_favourite":null,"offer_title":"Buy One Get One Free","distance":"1787.113586547191"},{"id":"5","category_id":"2","business_name":"Adventure Outfitters","description":"An outdoor gear and activity rental store with experienced guides and instructors.","image":"/uploads/outfit2.jpeg","contact_first_name":"Jane","contact_last_name":"Smith","email":"jane@example.com","password":"password456","hash":"hash456","address1":"456 High Street","address2":"","town":"Othertown","county":"Othercounty","postcode":"XY3 4AB","lat":"52.3555","lng":"1.174","website":"http://adventureoutfitters.com","featured":"1","active_cms":"1","active_app":"1","created":"2022-09-02 11:00:00","updated":"2023-02-27 09:22:41","category_name":"Clothes","member_favourite":null,"offer_title":"Refer a Friend","distance":"5360.241454806894"},{"id":"4","category_id":"1","business_name":"Pizza Palace","description":"A family-friendly pizza restaurant with a variety of toppings and sides.","image":"/uploads/pizzashop.png","contact_first_name":"John","contact_last_name":"Doe","email":"john@example.com","password":"password123","hash":"hash123","address1":"123 Main Street","address2":"","town":"Anytown","county":"Anycounty","postcode":"AB1 2CD","lat":"51.5074","lng":"0.127","website":"http://pizzapalace.com","featured":"0","active_cms":"1","active_app":"1","created":"2022-09-01 10:00:00","updated":"2023-02-27 09:22:31","category_name":"Restaurant","member_favourite":"1","offer_title":"Summer Clearance Sale","distance":"5372.494562523582"},{"id":"3","category_id":"3","business_name":"Relax Spa","description":"Come relax with our massages, facials, and more!","image":"/uploads/spa1.jpg","contact_first_name":"Sarah","contact_last_name":"Smith","email":"sarah@relaxspa.com","password":"password","hash":"hash","address1":"789 Elm St","address2":"","town":"Nowhere","county":"Nowherecounty","postcode":"24680","lat":"45.4321","lng":"-89.6543","website":"http://www.relaxspa.com","featured":"0","active_cms":"1","active_app":"1","created":"2023-02-27 12:00:00","updated":"2023-02-27 08:11:46","category_name":"Health & Beauty","member_favourite":null,"offer_title":"Holiday Special","distance":"1755.1321333564142"},{"id":"6","category_id":"3","business_name":"Serenity Spa","description":"A luxurious spa with a range of relaxing and rejuvenating treatments.","image":"/uploads/spa2.jpg","contact_first_name":"Sarah","contact_last_name":"Jones","email":"sarah@example.com","password":"password789","hash":"hash789","address1":"789 Park Lane","address2":"","town":"Somewhere","county":"Somecounty","postcode":"WX5 6YZ","lat":"53.4808","lng":"2.2426","website":"http://serenityspa.com","featured":"0","active_cms":"1","active_app":"1","created":"2022-09-03 12:00:00","updated":"2023-02-27 09:22:53","category_name":"Health & Beauty","member_favourite":"1","offer_title":"Free Shipping","distance":"5333.0796274196155"},{"id":"1","category_id":"2","business_name":"Tasty Tacos","description":"We serve the best tacos in town!","image":"/uploads/tacos2.png","contact_first_name":"John","contact_last_name":"Doe","email":"john@tastytacos.com","password":"password","hash":"hash","address1":"123 Main St","address2":"","town":"Anytown","county":"Anycounty","postcode":"12345","lat":"43.1234","lng":"-87.9876","website":"http://www.tastytacos.com","featured":"0","active_cms":"1","active_app":"1","created":"2023-02-27 12:00:00","updated":"2023-02-27 08:11:42","category_name":"Restaurant","member_favourite":null,"offer_title":"New Customer Discount","distance":"1826.8872329417595"}]
/// total_count : "6"

class BusinessResponse {
  BusinessResponse({
      bool? error, 
      String? message, 
      List<Data>? data, 
      String? totalCount,}){
    _error = error;
    _message = message;
    _data = data;
    _totalCount = totalCount;
}

  BusinessResponse.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _totalCount = json['total_count'];
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
  String? _totalCount;
BusinessResponse copyWith({  bool? error,
  String? message,
  List<Data>? data,
  String? totalCount,
}) => BusinessResponse(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
  totalCount: totalCount ?? _totalCount,
);
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;
  String? get totalCount => _totalCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['total_count'] = _totalCount;
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
/// category_name : "Activities"
/// member_favourite : null
/// offer_title : "Buy One Get One Free"
/// distance : "1787.113586547191"

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
      String? updated, 
      String? categoryName, 
      dynamic memberFavourite, 
      String? offerTitle, 
      String? distance,}){
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
    _categoryName = categoryName;
    _memberFavourite = memberFavourite;
    _offerTitle = offerTitle;
    _distance = distance;
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
    _categoryName = json['category_name'];
    _memberFavourite = json['member_favourite']??"";
    _offerTitle = json['offer_title'];
    _distance = json['distance'];
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
  String? _categoryName;
  dynamic _memberFavourite;
  String? _offerTitle;
  String? _distance;
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
  String? categoryName,
  dynamic memberFavourite,
  String? offerTitle,
  String? distance,
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
  categoryName: categoryName ?? _categoryName,
  memberFavourite: memberFavourite ?? _memberFavourite,
  offerTitle: offerTitle ?? _offerTitle,
  distance: distance ?? _distance,
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
  String? get categoryName => _categoryName;
  dynamic get memberFavourite => _memberFavourite;
  String? get offerTitle => _offerTitle;
  String? get distance => _distance;

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
    map['category_name'] = _categoryName;
    map['member_favourite'] = _memberFavourite;
    map['offer_title'] = _offerTitle;
    map['distance'] = _distance;
    return map;
  }

}