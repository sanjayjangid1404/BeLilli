
class AddFavouriteRequest {
  String businessID;
  String userID;



  AddFavouriteRequest(this.businessID,this.userID);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'business_id': businessID.trim(),
      'user_id': userID.trim(),


    };

    return map;
  }
}