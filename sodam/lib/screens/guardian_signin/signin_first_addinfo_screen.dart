import 'package:flutter/material.dart';
import 'package:sodam/models/guardian_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/guardian_signin/signin_second_addinfo_screen.dart';
import 'package:sodam/widgets/membership_next_button.dart';

class SigninFirstAddinfoScreen extends StatefulWidget {
  final GuardianData data;
  const SigninFirstAddinfoScreen({super.key, required this.data});

  @override
  State<SigninFirstAddinfoScreen> createState() =>
      _SigninFirstAddinfoScreenState();
}

class _SigninFirstAddinfoScreenState extends State<SigninFirstAddinfoScreen> {
  final _formKey = GlobalKey<FormState>();

  void _onNextButtonPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SigninSecondAddinfoScreen(
            data: widget.data, // 데이터 그대로 전달
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
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
                children: [
                  Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: screenHeight * 0.1),
                          const Text(
                            "앱 사용을 위해\n 추가 정보를\n 받고 있어요.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40,
                              fontFamily: "IBMPlexSansKRRegular",
                            ),
                          ),
                          const SizedBox(height: 60),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "사용자님의 기억점수 측정시에만\n사용되는 정보에요. ",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: "IBMPlexSansKRRegular",
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "탈퇴시 자동으로 삭제되며",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: "IBMPlexSansKRBold",
                                      color: Pallete.mainBlue, // 다른 색상 적용
                                    ),
                                  ),
                                  TextSpan(
                                    text: ", 앱 이외의 다른 곳에서 사용되지 않으니 안심하세요 :)",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: "IBMPlexSansKRRegular",
                                      color: Colors.black,
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
                ],
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
