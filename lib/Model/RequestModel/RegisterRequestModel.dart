
class RegisterRequestModel {
  String username;
  String password;
  String first_name;
  String last_name;
  String device_id;
  String device_type;


  RegisterRequestModel(this.username, this.password,this.first_name,this.last_name,this.device_id,this.device_type);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': username.trim(),
      'password': password.trim(),
      'first_name': first_name.trim(),
      'last_name': last_name.trim(),
      'device_id': device_id.trim(),
      'device_type': device_type.trim(),

    };

    return map;
  }
}