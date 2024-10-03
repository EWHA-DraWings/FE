class LoginData{
  final String id;
  final String password;
  final String user_id;

  LoginData(this.id, this.password, this.user_id);

  LoginData.fromJson(Map<String, dynamic> json)
      : id = json['accountName'],
        password = json['password'],
        user_id = json['user_id'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'password': password,
        'user_id': user_id,
      };
}