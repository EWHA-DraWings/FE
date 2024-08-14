import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sodam/models/elderly_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/login_screen.dart';
import 'package:sodam/widgets/membership_input_container.dart';

class UserRegisterPhoneScreen extends StatefulWidget {
  final ElderlyData data;
  const UserRegisterPhoneScreen({super.key, required this.data});

  @override
  State<UserRegisterPhoneScreen> createState() =>
      _UserRegisterPhoneScreenstate();
}

class _UserRegisterPhoneScreenstate extends State<UserRegisterPhoneScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onSubmitButtonPressed() async {
    //async여야 함?
    if (_formKey.currentState!.validate()) {
      final guardianPhone = _phoneController.text;

      final totalElderlyData = widget.data.copyWith(
        guardianPhone: guardianPhone,
      );

      //잘 전달 되었는지 콘솔에 출력해봄.잘 된다!
      print('Collected Guardian Data:');
      print('Name: ${totalElderlyData.name}');
      print('Role: ${totalElderlyData.role}');
      print('ID: ${totalElderlyData.id}');
      print('Password: ${totalElderlyData.password}');
      print('Phone: ${totalElderlyData.guardianPhone}');

      //백엔드에 전송할 데이터를 Map으로 생성
      final Map<String, dynamic> requestBody = {
        //guardian info
        "id": totalElderlyData.id,
        "name": totalElderlyData.name,
        "password": totalElderlyData.password,
        "guardianPhone": totalElderlyData.guardianPhone,
        "role": totalElderlyData.role,
      };
      //서버 연동 전, json 형태로 잘 전달되는지 출력
      String jsonString = jsonEncode(requestBody);
      print('Request Body in JSON format: $jsonString');
      // 백엔드로 HTTP POST 요청 보내기
      // final url = Uri.parse(
      //     'https://your-backend-url.com/api/register'); // 실제 API 엔드포인트로 변경 필요
      // final response = await http.post(
      //   url,
      //   headers: {'Content-Type': 'application/json'},
      //   body: jsonEncode(requestBody),
      // );

      // // 서버 응답 결과에 따라서 처리
      // if (response.statusCode == 200) {
      //   // 서버로부터의 성공 응답 처리
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => const LoginScreen(), // 회원가입 후 로그인 화면으로 이동
      //     ),
      //   );
      // } else {
      //   // 서버로부터의 실패 응답 처리
      //   print('Failed to register: ${response.body}');
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text('회원가입에 실패했습니다. 다시 시도해주세요.')),
      //   );
      // }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(), // 회원가입 후 로그인 화면으로 이동
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.sodamGreen,
      appBar: AppBar(
        backgroundColor: Pallete.sodamGreen,
        foregroundColor: Pallete.sodamDarkPink, //글씨 색
        title: const Text(
          "회원가입",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            fontFamily: "PoorStory",
          ),
        ),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '보호자의 연락처를\n입력해주세요.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 43,
                  fontWeight: FontWeight.normal,
                  fontFamily: "IBMPlexSansKRRegular",
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                '보호자 연락처 정보는\n보호자 계정과\n연결 시 사용됩니다.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  fontFamily: "IBMPlexSansKRRegular",
                ),
              ),
              Padding(
                //이름 입력창
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 20,
                ),
                child: MembershipInputContainer(
                  width: 300,
                  height: 50,
                  hintText: "전화번호",
                  controller: _phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '전화번호를 입력해주세요.';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return '전화번호는 숫자만 입력 가능합니다.';
                    }
                    if (value.length < 10 || value.length > 15) {
                      return '전화번호는 10자 이상 15자 이하이어야 합니다.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              //제출 버튼
              ElevatedButton(
                onPressed: _onSubmitButtonPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.sodamDarkPink, // 버튼 색상
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text(
                  "가입하기",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'IBMPlexSansKRRegular',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
