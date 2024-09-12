import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sodam/models/guardian_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/Guardian_membership/membership_elderly_extraInfo_screen.dart';
import 'package:sodam/widgets/birthday_input_widget.dart';
import 'package:sodam/widgets/membership_input_container.dart';
import 'package:sodam/widgets/membership_next_button.dart';

class MembershipAddinfoSecondScreen extends StatefulWidget {
  final GuardianData data;
  const MembershipAddinfoSecondScreen({super.key, required this.data});

  @override
  State<MembershipAddinfoSecondScreen> createState() =>
      _MembershipAddinfoSecondScreenState();
}

class _MembershipAddinfoSecondScreenState
    extends State<MembershipAddinfoSecondScreen> {
  // TextField controllers
  final _yearController = TextEditingController();
  final _monthController = TextEditingController();
  final _dayController = TextEditingController();
  final _phoneController1 = TextEditingController();
  final _phoneController2 = TextEditingController();
  final _phoneController3 = TextEditingController();
  final _emailController = TextEditingController();

  // Form
  final _formKey = GlobalKey<FormState>();

  void _onNextButtonPressed() async {
    if (_formKey.currentState!.validate()) {
      final year = _yearController.text;
      final month = _monthController.text;
      final day = _dayController.text;

      final email = _emailController.text;
      // 생년월일 문자열 조합
      final birthday = '$year-${month.padLeft(2, '0')}-${day.padLeft(2, '0')}';
      // 전화번호 문자열 조합
      final phoneNumber =
          '${_phoneController1.text}-${_phoneController2.text}-${_phoneController3.text}';

      final extraGuardianData = widget.data.copyWith(
        birth: birthday,
        phone: phoneNumber,
        email: email,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MemebershipElderlyExtraInfoScreen(
            data: extraGuardianData, //
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
        backgroundColor: Pallete.mainWhite,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
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
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.11),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "생년월일",
                          style: TextStyle(
                            color: Pallete.mainBlack,
                            fontSize: 20,
                            fontFamily: "IBMPlexSansKRRegular",
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0), // 위쪽 여백 제거
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          BirthdayInputWidget(
                              yearController: _yearController,
                              monthController: _monthController,
                              dayController: _dayController),
                          const SizedBox(height: 20),
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
                                  fontSize: 20,
                                  fontFamily: "IBMPlexSansKRRegular",
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 80,
                                child: MembershipInputContainer(
                                  height: 40,
                                  controller: _phoneController1,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '번호를 입력해주세요.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 7),
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
                                width: 90,
                                child: MembershipInputContainer(
                                  height: 40,
                                  controller: _phoneController2,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '번호를 입력해주세요.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 7),
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
                                width: 90,
                                child: MembershipInputContainer(
                                  height: 40,
                                  controller: _phoneController3,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '번호를 입력해주세요.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth * 0.11, bottom: 10),
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "이메일",
                                style: TextStyle(
                                  color: Pallete.mainBlack,
                                  fontSize: 20,
                                  fontFamily: "IBMPlexSansKRRegular",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.8,
                            child: MembershipInputContainer(
                              height: 40,
                              controller: _emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '이메일을 입력해주세요.';
                                }
                                if (!RegExp(
                                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                    .hasMatch(value)) {
                                  return '유효한 이메일 주소를 입력해주세요.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
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
