
class RemoveFavRequest {
  String userID;
  String businessId;


  RemoveFavRequest(this.userID, this.businessId);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'user_id': userID.trim(),
      'business_id': businessId.trim(),

    };

    return map;
  }
}