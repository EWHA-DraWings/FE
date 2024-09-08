import 'package:flutter/material.dart';
import 'package:sodam/models/guardian_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/Guardian_membership/membership_idpw_screen.dart';
import 'package:sodam/widgets/membership_input_container.dart';
import 'package:sodam/widgets/membership_next_button.dart';

class MembershipNameScreen extends StatefulWidget {
  final GuardianData data;
  const MembershipNameScreen({super.key, required this.data});

  @override
  State<MembershipNameScreen> createState() => _MembershipNameScreenState();
}

class _MembershipNameScreenState extends State<MembershipNameScreen> {
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
          builder: (context) => MembershipIdpwScreen(
            data: updatedguardianData, //생성한 guardianData 객체를 전달.
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
        foregroundColor: Pallete.sodamDarkPink, // 글씨 색
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
              Column(
                children: [
                  const Text(
                    "성함이 어떻게\n되시나요?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: "IBMPlexSansKRRegular",
                    ),
                  ),
                  const SizedBox(height: 60),
                  MembershipInputContainer(
                    height: 70,
                    
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '이름은 필수 입력 사항입니다.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  MembershipNextButton(
                    onPressed:
                        _onNextButtonPressed, // destination을 onPressed에서 처리하기 때문에 제거
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
