class LoginData {
  final String id;
  //final String password;
  final String user_id;
  final String name;
  final String token;
  final bool isElderly;

  LoginData(this.id, this.user_id, this.name, this.token, this.isElderly);

  LoginData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        //password = json['password'], -> 사용 못 하지 않나?
        user_id = json['_id'],
        name = json['name'],
        token = json['token'],
        isElderly = json['isElderly'];

  Map<String, dynamic> toJson() => {
        'id': id,
        //'password': password,
        'user_id': user_id,
        'token': token,
      };
}
