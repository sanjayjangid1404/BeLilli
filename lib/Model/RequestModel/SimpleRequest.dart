
class SimpleRequest {
  String userID;

  SimpleRequest(this.userID);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'user_id': userID.trim(),

    };

    return map;
  }
}