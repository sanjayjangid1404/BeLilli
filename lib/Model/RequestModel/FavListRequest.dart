
class FavListRequest {

  String latitude;

  String userId;
  String longitude;


  FavListRequest(
      this.longitude,this.latitude,this.userId);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {

      'latitude': latitude.trim(),
      'longitude': longitude.trim(),
      'user_id': userId.trim(),


    };

    return map;
  }
}