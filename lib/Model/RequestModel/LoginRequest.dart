
class LoginRequest {
  String username;
  String password;
  String device_id;
  String device_type;


  LoginRequest(this.username, this.password,this.device_type,this.device_id);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': username.trim(),
      'password': password.trim(),
      'device_id': device_id.trim(),
      'device_type': device_type.trim(),

    };

    return map;
  }
}