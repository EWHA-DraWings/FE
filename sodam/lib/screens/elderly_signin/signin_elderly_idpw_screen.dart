import 'package:flutter/material.dart';
import 'package:sodam/global.dart';
import 'package:sodam/models/elderly_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/elderly_signin/signin_elderly_phone_screen.dart';
import 'package:sodam/screens/elderly_signin/widgets/signin_elderly_input_container.dart';
import 'package:sodam/screens/elderly_signin/widgets/signin_elderly_next_button.dart';
import 'package:http/http.dart' as http;

class SigninElderlyIdpwScreen extends StatefulWidget {
  final ElderlyData data; //데이터를 받기 위해 추가
  const SigninElderlyIdpwScreen({super.key, required this.data});

  @override
  State<SigninElderlyIdpwScreen> createState() => _SigninIdpwScreenState();
}

class _SigninIdpwScreenState extends State<SigninElderlyIdpwScreen> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _onNextButtonPressed() async {
    // 현재 폼의 상태가 유효한지 검사합니다.
    if (_formKey.currentState!.validate()) {
      // 폼이 유효할 경우, 입력된 아이디와 비밀번호를 가져옵니다.
      final id = _idController.text;
      final password = _passwordController.text;

      final updatedElderlyData = widget.data.copyWith(
        id: id,
        password: password,
      );

      // 백엔드로 HTTP POST 요청 보내기
      //사용자 id 함께 보내서 id 중복 검사
      final url =
          Uri.parse('http://${Global.ipAddr}:3000/api/users/check-id/$id');

      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        //사용 가능 id
        // 다음 화면으로 이동하며, 현재 화면의 데이터를 전달합니다.
        print('사용 가능한 아이디');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SigninElderlyPhoneScreen(
              data: updatedElderlyData,
            ),
          ),
        );
      } else if (response.statusCode == 400) {
        print('아이디 중복: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('사용 중인 아이디입니다. 다른 아이디를 사용해주세요.')),
        );
      } else {
        // 서버로부터의 실패 응답 처리
        print('아이디 중복 검사 실패(server error): ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('500: 서버 오류로 아이디 중복 검사에 실패했습니다. 다시 시도해주세요.')),
        );
      }
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
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${widget.data.name}님, 반가워요!\n",
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontFamily: "IBMPlexSansKRRegular",
                                      color: Pallete.mainBlue, // 다른 색상 적용
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "사용할 아이디와\n비밀번호를\n입력해주세요.",
                                    style: TextStyle(
                                      fontSize: 48,
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
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "아이디",
                                      style: TextStyle(
                                        color: Pallete.mainBlack,
                                        fontSize: 30,
                                        fontFamily: "IBMPlexSansKRRegular",
                                      ),
                                    ),
                                  ),
                                ),
                                SigninElderlyInputContainer(
                                  height: 60,
                                  controller: _idController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '아이디는 필수 입력 사항입니다.';
                                    }
                                    if (value.length < 6 || value.length > 20) {
                                      return '아이디는 6자 이상 20자 이하이어야 합니다.';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: screenWidth * 0.11),
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "비밀번호",
                                      style: TextStyle(
                                        color: Pallete.mainBlack,
                                        fontSize: 30,
                                        fontFamily: "IBMPlexSansKRRegular",
                                      ),
                                    ),
                                  ),
                                ),
                                SigninElderlyInputContainer(
                                  height: 60,
                                  controller: _passwordController,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '비밀번호는 필수 입력 사항입니다.';
                                    }
                                    if (value.length < 8 ||
                                        !RegExp(r'[A-Z]').hasMatch(value) ||
                                        !RegExp(r'[a-z]').hasMatch(value) ||
                                        !RegExp(r'[0-9]').hasMatch(value) ||
                                        !RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                            .hasMatch(value)) {
                                      return '비밀번호는 8자 이상이어야 하며 대문자, 소문자, 숫자, 특수문자를 포함해야 합니다.';
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
            child: SigninElderlyNextButton(
              onPressed:
                  _onNextButtonPressed, // destination을 onPressed에서 처리하기 때문에 제거
            ),
          ),
        ],
      ),
    );
  }
}
