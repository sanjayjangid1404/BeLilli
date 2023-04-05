
class BusinessDetailsRequest {
  String businessID;



  BusinessDetailsRequest(this.businessID);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'business_id': businessID.trim(),


    };

    return map;
  }
}