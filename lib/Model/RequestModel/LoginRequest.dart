
class LoginRequest {
  String username;
  String password;


  LoginRequest(this.username, this.password);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': username.trim(),
      'password': password.trim(),

    };

    return map;
  }
}