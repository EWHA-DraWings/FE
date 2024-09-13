import 'package:flutter/material.dart';
import 'package:sodam/models/guardian_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/guardian_signin/membership_elderly_extraInfo_screen.dart';
import 'package:sodam/screens/guardian_signin/signin_fourth_elderly_addinfo_screen.dart';
import 'package:sodam/widgets/membership_input_container.dart';
import 'package:sodam/widgets/membership_next_button.dart';

class SigninThirdAddinfoScreen extends StatefulWidget {
  final GuardianData data; //데이터를 받기 위해 추가
  const SigninThirdAddinfoScreen({super.key, required this.data});

  @override
  State<SigninThirdAddinfoScreen> createState() =>
      _SigninThirdAddinfoScreenState();
}

class _SigninThirdAddinfoScreenState extends State<SigninThirdAddinfoScreen> {
  final _jobcontroller = TextEditingController();
  final _addresscontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onNextButtonPressed() {
    // 현재 폼의 상태가 유효한지 검사합니다.
    if (_formKey.currentState!.validate()) {
      // 폼이 유효할 경우, 입력된 아이디와 비밀번호를 가져옵니다.
      final job = _jobcontroller.text;
      final address = _addresscontroller.text;

      // 객체에 id,pw도 추가
      final updatedGuardianData2 = widget.data.copyWith(
        job: job,
        address: address,
      );

      // 다음 화면으로 이동하며, 현재 화면의 데이터를 전달합니다.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SigninFourthElderlyAddinfoScreen(
            data: updatedGuardianData2, // 업데이트된 GuardianData 객체
          ),
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
                                    text: "먼저,\n ",
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontFamily: "IBMPlexSansKRRegular",
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "보호자",
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
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "직업",
                                      style: TextStyle(
                                        color: Pallete.mainBlack,
                                        fontSize: 20,
                                        fontFamily: "IBMPlexSansKRRegular",
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                MembershipInputContainer(
                                  height: 45,
                                  controller: _jobcontroller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '직업을 입력해주세요.';
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: screenWidth * 0.11),
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Text(
                                          "거주 지역",
                                          style: TextStyle(
                                            color: Pallete.mainBlack,
                                            fontSize: 20,
                                            fontFamily: "IBMPlexSansKRRegular",
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "ex.서울",
                                          style: TextStyle(
                                            color: Pallete.mainBlack,
                                            fontSize: 10,
                                            fontFamily: "IBMPlexSansKRRegular",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                MembershipInputContainer(
                                  height: 45,
                                  controller: _addresscontroller,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '거주지역을 입력해주세요.';
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
            child: MembershipNextButton(
              onPressed:
                  _onNextButtonPressed, // destination을 onPressed에서 처리하기 때문에 제거
            ),
          ),
        ],
      ),
    );
  }
}
