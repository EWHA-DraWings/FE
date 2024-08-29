import 'package:flutter/material.dart';
import 'package:sodam/models/guardian_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/Guardian_membership/membership_guardian_extraInfo_screen.dart';
import 'package:sodam/widgets/membership_input_container.dart';
import 'package:sodam/widgets/membership_next_button.dart';

class MembershipIdpwScreen extends StatefulWidget {
  final GuardianData data; //데이터를 받기 위해 추가
  const MembershipIdpwScreen({super.key, required this.data});

  @override
  State<MembershipIdpwScreen> createState() => _MembershipIdpwScreenState();
}

class _MembershipIdpwScreenState extends State<MembershipIdpwScreen> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onNextButtonPressed() {
    // 현재 폼의 상태가 유효한지 검사합니다.
    if (_formKey.currentState!.validate()) {
      // 폼이 유효할 경우, 입력된 아이디와 비밀번호를 가져옵니다.
      final id = _idController.text;
      final password = _passwordController.text;

      // 객체에 id,pw도 추가
      final updatedGuardianData2 = widget.data.copyWith(
        id: id,
        password: password,
      );

      // 다음 화면으로 이동하며, 현재 화면의 데이터를 전달합니다.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MemebershipExtrainfoScreen(
            data: updatedGuardianData2, // 업데이트된 GuardianData 객체
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.sodamIvory,
      appBar: AppBar(
        backgroundColor: Pallete.sodamIvory,
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
          key: _formKey, // FormKey 설정
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${widget.data.name}님,\n사용할 아이디와\n비밀번호를\n입력해주세요.", // 빼도 됨
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 40,
                  fontFamily: 'IBMPlexSansKRRegular',
                ),
              ),
              const SizedBox(height: 60),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MembershipInputContainer(
                    width: 300,
                    height: 60,
                    hintText: "아이디",
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
                  MembershipInputContainer(
                    width: 300,
                    height: 60,
                    hintText: "비밀번호",
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
                          !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                        return '비밀번호는 8자 이상이어야 하며 대문자, 소문자, 숫자, 특수문자를 포함해야 합니다.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  MembershipNextButton(
                    onPressed: _onNextButtonPressed,
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
