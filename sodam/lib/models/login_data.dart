import 'package:flutter/material.dart';

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

class LoginDataProvider with ChangeNotifier {
  LoginData? _loginData;

  LoginData? get loginData => _loginData;

  void setLoginData(LoginData loginData) {
    _loginData = loginData;
    notifyListeners();
  }
}
// import 'package:flutter/material.dart';

// class LoginData with ChangeNotifier {
//   final String id;
//   final String user_id;
//   final String name;
//   String token;
//   final bool isElderly;

//   LoginData(this.id, this.user_id, this.name, this.token, this.isElderly);

//   LoginData.fromJson(Map<String, dynamic> json)
//       : id = json['id'],
//         user_id = json['_id'],
//         name = json['name'],
//         token = json['token'],
//         isElderly = json['isElderly'];

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'user_id': user_id,
//         'token': token,
//       };

//   // 토큰을 업데이트하는 메서드
//   void updateToken(String newToken) {
//     // 새로운 토큰으로 업데이트
//     // 만약 필요한 경우, 다른 상태도 업데이트할 수 있음
//     token = newToken; // 직접 수정하는 대신 notifyListeners() 호출
//     notifyListeners(); // 상태 변경 알림
//   }
// }
