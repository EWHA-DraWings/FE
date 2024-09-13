import 'package:flutter/material.dart';
import 'package:sodam/models/guardian_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/guardian_signin/signin_idpw_screen.dart';
import 'package:sodam/widgets/membership_input_container.dart';
import 'package:sodam/widgets/membership_next_button.dart';

class SigninNameScreen extends StatefulWidget {
  final GuardianData data;
  const SigninNameScreen({super.key, required this.data});

  @override
  State<SigninNameScreen> createState() => _SigninNameScreenState();
}

class _SigninNameScreenState extends State<SigninNameScreen> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onNextButtonPressed() {
    // 현재 폼의 상태가 유효한지 검사합니다.
    if (_formKey.currentState!.validate()) {
      // 폼이 유효할 경우, 입력된 이름을 가져옴.
      final name = _nameController.text;

      final updatedguardianData = widget.data.copyWith(
        name: name,
      );
      // 다음 화면으로 이동하며, 현재 화면의 데이터를 전달합니다.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SigninIdpwScreen(
            data: updatedguardianData, //생성한 guardianData 객체를 전달.
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              SizedBox(height: screenHeight * 0.1),
                              const Text(
                                "성함이 어떻게\n되시나요?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 40,
                                  fontFamily: "IBMPlexSansKRRegular",
                                ),
                              ),
                              const SizedBox(height: 60),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: screenWidth * 0.11),
                                child: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "이름",
                                    style: TextStyle(
                                      color: Pallete.mainBlack,
                                      fontSize: 20,
                                      fontFamily: "IBMPlexSansKRRegular",
                                    ),
                                  ),
                                ),
                              ),
                              MembershipInputContainer(
                                height: 60,
                                controller: _nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '이름은 필수 입력 사항입니다.';
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
