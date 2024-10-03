import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sodam/models/guardian_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/login_screen.dart';
import 'package:sodam/widgets/membership_input_container.dart';
import 'package:http/http.dart' as http;

class SigninFinalElderlyScreen extends StatefulWidget {
  final GuardianData data; //데이터를 받기 위해 추가
  const SigninFinalElderlyScreen({super.key, required this.data});

  @override
  State<SigninFinalElderlyScreen> createState() =>
      _SigninFinalElderlyScreenState();
}

class _SigninFinalElderlyScreenState extends State<SigninFinalElderlyScreen> {
  final _addresscontroller = TextEditingController();
  final _conditionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _onNextButtonPressed() async {
    // 현재 폼의 상태가 유효한지 검사합니다.
    if (_formKey.currentState!.validate()) {
      // 폼이 유효할 경우, 입력된 아이디와 비밀번호를 가져옵니다.
      final elderlyAddress = _addresscontroller.text;
      final existingConditions = _conditionController.text;

      // 최종 데이터 모으기
      final totalGuardianData = widget.data.copyWith(
        existingConditions: existingConditions,
        elderlyAddress: elderlyAddress,
      );
      //잘 전달 되었는지 콘솔에 출력해봄.잘 된다!
      print('Collected Guardian Data:');
      print('Name: ${totalGuardianData.name}');
      print('Role: ${totalGuardianData.role}');
      print('ID: ${totalGuardianData.id}');
      print('Password: ${totalGuardianData.password}');
      print('Birth: ${totalGuardianData.birth}');
      print('Phone: ${totalGuardianData.phone}');
      print('Email: ${totalGuardianData.email}');
      print('Job: ${totalGuardianData.job}');
      print('role: ${totalGuardianData.role}');
      print('elderlyName: ${totalGuardianData.elderlyName}');
      print('elderlyPhone: ${totalGuardianData.elderlyPhone}');
      print('elderlyAddress: ${totalGuardianData.elderlyAddress}');
      print('elderlyBirthday: ${totalGuardianData.elderlyBirthday}');
      print('existingConditions: ${totalGuardianData.existingConditions}');

      //백엔드에 전송할 데이터를 Map으로 생성
      final Map<String, dynamic> requestBody = {
        //guardian info
        "id": totalGuardianData.id,
        "name": totalGuardianData.name,
        "password": totalGuardianData.password,
        "email": totalGuardianData.email,
        "phone": totalGuardianData.phone,
        "address": totalGuardianData.address,
        "birth": totalGuardianData.birth,
        "job": totalGuardianData.job,
        //"role": totalGuardianData.role,
        //elderly info
        "elderlyName": totalGuardianData.elderlyName,
        "elderlyPhone": totalGuardianData.elderlyPhone,
        "elderlyAddress": totalGuardianData.elderlyAddress,
        "elderlyBirthday": totalGuardianData.elderlyBirthday,
        "existingConditions": totalGuardianData.existingConditions,
      };
      //서버 연동 전, json 형태로 잘 전달되는지 출력
      String jsonString = jsonEncode(requestBody);
      print('Request Body in JSON format: $jsonString');

      //url에 들어가는 IP주소: ex) 10.0.2.2(에뮬레이터 localhost)
      String IPAddr = '52.78.140.87';

      // 백엔드로 HTTP POST 요청 보내기
      final url = Uri.parse('http://$IPAddr:3000/api/users/guardian/register');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );
      print(response.statusCode);
      // 서버 응답 결과에 따라서 처리
      if (response.statusCode == 201) {
        // 서버로부터의 성공 응답 처리
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(), // 회원가입 후 로그인 화면으로 이동
          ),
        );
      } else {
        //500(서버 오류)
        // 서버로부터의 실패 응답 처리
        print('Failed to register: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('회원가입에 실패했습니다. 다시 시도해주세요.')),
        );
      }
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const LoginScreen(), // 회원가입 후 로그인 화면으로 이동
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Pallete.mainWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Form(
                        key: _formKey, // FormKey 설정
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "마지막으로,\n ",
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontFamily: "IBMPlexSansKRRegular",
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "사용자",
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontFamily: "IBMPlexSansKRRegular",
                                      color: Pallete.mainBlue, // 다른 색상 적용
                                    ),
                                  ),
                                  TextSpan(
                                    text: "님의 정보를\n 입력해주세요.",
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontFamily: "IBMPlexSansKRRegular",
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: screenWidth * 0.11),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        const Text(
                                          "거주 지역",
                                          style: TextStyle(
                                            color: Pallete.mainBlack,
                                            fontSize: 20,
                                            fontFamily: "IBMPlexSansKRRegular",
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          "ex.서울",
                                          style: TextStyle(
                                            color: Pallete.mainBlack
                                                .withOpacity(0.7),
                                            fontSize: 15,
                                            fontFamily: "IBMPlexSansKRRegular",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                MembershipInputContainer(
                                  height: 45,
                                  controller: _addresscontroller,
                                  obscureText: false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '거주지역을 입력해주세요.';
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: screenWidth * 0.11),
                                  child: Column(
                                    children: [
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "건강상태를 입력해주세요.",
                                          style: TextStyle(
                                            color: Pallete.mainBlack,
                                            fontSize: 20,
                                            fontFamily: "IBMPlexSansKRRegular",
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          " *없는 경우 '없음'이라고 기입해주세요.",
                                          style: TextStyle(
                                            color: Pallete.mainBlack
                                                .withOpacity(0.7),
                                            fontSize: 15,
                                            fontFamily: "IBMPlexSansKRRegular",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                MembershipInputContainer(
                                  height: 45,
                                  controller: _conditionController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '없는 경우 \'없음\'이라고 입력해주세요.';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: //제출 버튼
                SizedBox(
              width: screenWidth * 0.8,
              height: 60,
              child: ElevatedButton(
                onPressed: _onNextButtonPressed,
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
                  "가입하기",
                  style: TextStyle(
                    fontSize: 20,
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
