
class ProfileUpdateRequest {
  String username;
  String fName;
  String lName;


  ProfileUpdateRequest(this.username, this.fName,this.lName);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'user_id': username.trim(),
      'first_name': fName.trim(),
      'last_name': lName.trim(),

    };

    return map;
  }
}