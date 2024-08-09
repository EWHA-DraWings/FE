import 'package:flutter/material.dart';
import 'package:sodam/models/guardian_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/Guardian_membership/membership_screen.dart';
import 'package:sodam/screens/login_screen.dart';
import 'package:sodam/widgets/membership_input_container.dart';
import 'package:sodam/widgets/membership_next_button.dart';

class MemebershipExtrainfoScreen extends StatefulWidget {
  final GuardianData data;
  const MemebershipExtrainfoScreen({super.key, required this.data});

  @override
  State<MemebershipExtrainfoScreen> createState() =>
      _MemebershipExtrainfoScreenState();
}

class _MemebershipExtrainfoScreenState
    extends State<MemebershipExtrainfoScreen> {
  //textField controller
  final _birthdayController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _jobController = TextEditingController();
  final _residenceController = TextEditingController();

  //생년월일
  DateTime? tempPickedDate;
  DateTime _selectedDate = DateTime.now();
   
  //form
  final _formKey = GlobalKey<FormState>();

  void _onNextButtonPressed() {
    if (_formKey.currentState!.validate()) {
      final birthday = _birthdayController.text;
      final phoneNumber = _phoneController.text;
      final email = _emailController.text;
      final job = _jobController.text;
      final residenceArea = _residenceController.text;

      final updatedGuardianData2 = widget.data.copyWith(
        birth: birthday,
        phone: phoneNumber,
        email: email,
        job: job,
        residenceArea: residenceArea,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(
            data: updatedGuardianData2, //
          ),
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
            fontFamily: "Gugi",
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
                "앱 사용을 위해\n추가 정보를\n받고 있어요.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'IBMPlexSansKRRegular',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                textAlign: TextAlign.center,
                "앱의 기억점수 측정시에만 사용되는 정보에요. 탈퇴시 자동으로\n삭제되며, 앱 외의 다른 곳에서 사용되지 않으니 안심하세요!",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'IBMPlexSansKRRegular',
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                textAlign: TextAlign.center,
                "사용자님의 정보를 입력해주세요.",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'IBMPlexSansKRRegular',
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(top: 0.0), // 위쪽 여백 제거
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    MembershipInputContainer(
                      width: 300,
                      height: 50,
                      hintText: "생년월일",
                      controller: _birthdayController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '생년월일을 입력해주세요.';
                        }
                        // 여기에 생년월일 형식 검증 로직 추가 가능
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    MembershipInputContainer(
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
                    const SizedBox(height: 20),
                    MembershipInputContainer(
                      width: 300,
                      height: 50,
                      hintText: "이메일",
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
                    const SizedBox(height: 20),
                    MembershipInputContainer(
                      width: 300,
                      height: 50,
                      hintText: "직업",
                      controller: _jobController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '직업을 입력해주세요.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    MembershipInputContainer(
                      width: 300,
                      height: 50,
                      hintText: "거주 지역",
                      controller: _residenceController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '거주 지역을 입력해주세요.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    //제출 버튼
                    ElevatedButton(
                      onPressed: _onNextButtonPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Pallete.sodamDarkPink, // 버튼 색상
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                      ),
                      child: const Text(
                        "제출하기",
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
            ],
          ),
        ),
      ),
    );
  }
}
