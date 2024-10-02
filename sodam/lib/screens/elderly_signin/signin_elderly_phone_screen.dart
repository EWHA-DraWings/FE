import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sodam/models/elderly_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/elderly_signin/widgets/signin_elderly_input_container.dart';
import 'package:sodam/screens/login_screen.dart';
import 'package:sodam/widgets/membership_input_container.dart';

class SigninElderlyPhoneScreen extends StatefulWidget {
  final ElderlyData data;

  const SigninElderlyPhoneScreen({super.key, required this.data});

  @override
  State<SigninElderlyPhoneScreen> createState() =>
      _SigninElderlyPhoneScreenstate();
}

class _SigninElderlyPhoneScreenstate extends State<SigninElderlyPhoneScreen> {
  final _phoneController1 = TextEditingController();
  final _phoneController2 = TextEditingController();
  final _phoneController3 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onSubmitButtonPressed() async {
    if (_formKey.currentState!.validate()) {
      final phoneNumber =
          '${_phoneController1.text}-${_phoneController2.text}-${_phoneController3.text}';

      final totalElderlyData = widget.data.copyWith(
        guardianPhone: phoneNumber,
      );

      // 잘 전달 되었는지 콘솔에 출력해봄. 잘 된다!
      print('Collected Guardian Data:');
      print('Name: ${totalElderlyData.name}');
      print('Role: ${totalElderlyData.role}');
      print('ID: ${totalElderlyData.id}');
      print('Password: ${totalElderlyData.password}');
      print('Phone: ${totalElderlyData.guardianPhone}');

      // 백엔드에 전송할 데이터를 Map으로 생성
      final Map<String, dynamic> requestBody = {
        "id": totalElderlyData.id,
        "name": totalElderlyData.name,
        "password": totalElderlyData.password,
        "guardianPhone": totalElderlyData.guardianPhone,
        "role": totalElderlyData.role,
      };

      // 서버 연동 전, json 형태로 잘 전달되는지 출력
      String jsonString = jsonEncode(requestBody);
      print('Request Body in JSON format: $jsonString');

      // 백엔드로 HTTP POST 요청 보내기
      // final url = Uri.parse('https://your-backend-url.com/api/register'); // 실제 API 엔드포인트로 변경 필요
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
      //       builder: (context) => const TimeSelectScreen(), // 회원가입 후 시간 설정 화면으로 이동
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
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Pallete.mainWhite,
      appBar: AppBar(
        backgroundColor: Pallete.mainWhite,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "보호자",
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontFamily: "IBMPlexSansKRRegular",
                                    color: Pallete.mainBlue, // 다른 색상 적용
                                  ),
                                ),
                                TextSpan(
                                  text: "님의\n 전화번호를\n 입력해주세요.",
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontFamily: "IBMPlexSansKRRegular",
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "보호자 ",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: "IBMPlexSansKRRegular",
                                    color: Colors.black, // 다른 색상 적용
                                  ),
                                ),
                                TextSpan(
                                  text: "계정과 연동",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: "IBMPlexSansKRBold",
                                    color: Pallete.mainBlue,
                                  ),
                                ),
                                TextSpan(
                                  text: "하기 위해 필요해요.",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: "IBMPlexSansKRRegular",
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 0.0), // 위쪽 여백 제거
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: screenWidth * 0.11,
                                    bottom: 10,
                                  ),
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "전화번호",
                                      style: TextStyle(
                                        color: Pallete.mainBlack,
                                        fontSize: 30,
                                        fontFamily: "IBMPlexSansKRRegular",
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: screenWidth * 0.07),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 90,
                                        child: SigninElderlyInputContainer(
                                          height: 50,
                                          controller: _phoneController1,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return '번호를 입력해주세요.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 7),
                                        child: Text(
                                          "-",
                                          style: TextStyle(
                                            color: Pallete.mainBlack,
                                            fontSize: 20,
                                            fontFamily: "IBMPlexSansKRRegular",
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: SigninElderlyInputContainer(
                                          height: 50,
                                          controller: _phoneController2,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return '번호를 입력해주세요.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 7),
                                        child: Text(
                                          "-",
                                          style: TextStyle(
                                            color: Pallete.mainBlack,
                                            fontSize: 20,
                                            fontFamily: "IBMPlexSansKRRegular",
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: SigninElderlyInputContainer(
                                          height: 50,
                                          controller: _phoneController3,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return '번호를 입력해주세요.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                // 제출 버튼
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: SizedBox(
              width: screenWidth * 0.8,
              height: 60,
              child: ElevatedButton(
                onPressed: _onSubmitButtonPressed,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Pallete.mainWhite,
                  backgroundColor: Pallete.mainBlue, // 버튼 배경 색상
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // 버튼 모서리 둥글기
                  ),
                ),
                child: const Text(
                  '가입하기',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'IBMPlexSansKRRegular',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
