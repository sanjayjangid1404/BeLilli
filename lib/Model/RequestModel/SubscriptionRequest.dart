
class SubscriptionRequest {
  String userID;
  String payment_method;
  String payment_status;
  String payment_date;
  String app_password;
  String receipt;


  SubscriptionRequest(this.userID, this.payment_method,this.payment_date,this.payment_status,this.app_password,this.receipt);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'user_id': userID.trim(),
      'payment_method': payment_method.trim(),
      'payment_status': payment_status.trim(),
      'payment_date': payment_date.trim(),
      'app_password': app_password.trim(),
      'receipt': receipt.trim(),

    };

    return map;
  }
}