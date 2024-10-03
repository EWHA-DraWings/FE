import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/main_screen.dart';

import 'package:sodam/widgets/login_button.dart';
import 'package:sodam/widgets/login_input_container.dart';

import 'package:sodam/widgets/move_to_membership_button.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _idController = TextEditingController();

  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _onLoginButtonPressed() async {
    if (_formKey.currentState!.validate()) {
      // 폼이 유효할 경우, 입력된 아이디와 비밀번호를 가져옵니다.
      final id = _idController.text;
      final password = _passwordController.text;

      //확인
      print('id: $id');
      print('password: $password');

      //백엔드에 전송할 데이터를 Map으로 생성
      final Map<String, dynamic> requestBody = {
        //login info
        "id": id,
        "password": password,
      };
      //서버 연동 전, json 형태로 잘 전달되는지 출력
      String jsonString = jsonEncode(requestBody);
      print('Request Body in JSON format: $jsonString');

      //url에 들어가는 IP주소: ex) 10.0.2.2(에뮬레이터 localhost)
      String IPAddr = '52.78.140.87';

      // 백엔드로 HTTP POST 요청 보내기
      final url = Uri.parse('http://$IPAddr:3000/api/auth/login');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );
      print(response.statusCode);
      // 서버 응답 결과에 따라서 처리
      if (response.statusCode == 200) {
        // 서버로부터의 성공 응답 처리
        //JSON 응답 파싱
        final Map<String, dynamic> data = jsonDecode(response.body);

        //isElderly 값 가져오기
        bool isElderly = data['isElderly'];

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(
              isGuardian: !isElderly,
            ), // 회원가입 후 로그인 화면으로 이동
          ),
        );
      } else if (response.statusCode == 401) {
        print('Failed to login: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('401: 로그인에 실패했습니다. 다시 시도해주세요.')),
        );
      } else {
        //500(서버 오류)
        // 서버로부터의 실패 응답 처리
        print('Failed to login(server error): ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('500: 서버 오류로 로그인에 실패했습니다. 다시 시도해주세요.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Pallete.mainWhite,
      appBar: AppBar(
        backgroundColor: Pallete.mainWhite,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "안녕하세요, 소담이에요!",
                      style: TextStyle(
                        color: Pallete.mainBlack,
                        fontFamily: "IBMPlexSansKRBold",
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "다시 만나 반가워요 :)",
                      style: TextStyle(
                        color: Pallete.mainBlack,
                        fontFamily: "IBMPlexSansKRBold",
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '아이디',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: "IBMPlexSansKRRegular",
                        color: Pallete.mainBlack,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                //아이디
                LoginInputContainer(
                  width: 220,
                  height: 60,
                  controller: _idController,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '비밀번호',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: "IBMPlexSansKRRegular",
                        color: Pallete.mainBlack,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                //비번
                LoginInputContainer(
                  width: 220,
                  height: 60,
                  controller: _passwordController,
                ),
                const SizedBox(
                  height: 50,
                ),
                LoginButton(
                  loginButtonPressed: _onLoginButtonPressed,
                ),
                const SizedBox(
                  height: 20,
                ), // Spacer 대신 SizedBox 추가
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "아직 계정이 없으신가요?",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      MoveToMembershipButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
