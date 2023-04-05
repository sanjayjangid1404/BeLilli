
class BusinessFilterRequest {

  String pagecount;
  String limit;
  String category_ids;
  String latitude;

  String userId;
  String longitude;
  String search_key;


  BusinessFilterRequest(
      this.longitude,this.category_ids,this.search_key,
      this.pagecount,this.limit,this.latitude,this.userId);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {

      'limit': limit.trim(),
      'latitude': latitude.trim(),
      'category_ids': category_ids.trim(),
      'longitude': longitude.trim(),
      // 'pagecount': pagecount.trim(),
      'search_key': search_key.trim(),
      'user_id': userId.trim(),


    };

    return map;
  }
}