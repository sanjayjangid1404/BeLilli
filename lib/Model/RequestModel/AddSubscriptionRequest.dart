
class AddSubscriptionRequest {
  String payment_method;
  String payment_status;
  String payment_date;
  String userID;
  String receipt;
  String app_password;




  AddSubscriptionRequest(this.payment_method,this.userID,this.payment_status,this.payment_date,this.receipt,this.app_password);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'payment_method': payment_method.trim(),
      'payment_status': payment_status.trim(),
      'user_id': userID.trim(),
      'payment_date': payment_date.trim(),
      'receipt': receipt.trim(),
      'app_password': app_password.trim(),


    };

    return map;
  }
}