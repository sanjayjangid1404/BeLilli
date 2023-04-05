
class ForgetPassword {
  String username;
  String password;


  ForgetPassword(this.username, this.password);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'user_id': username.trim(),
      'new_password': password.trim(),

    };

    return map;
  }
}