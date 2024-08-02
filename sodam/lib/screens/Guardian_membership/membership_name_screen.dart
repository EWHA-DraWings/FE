import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/Guardian_membership/membership_idpw_screen.dart';
import 'package:sodam/widgets/membership_input_container.dart';
import 'package:sodam/widgets/membership_next_button.dart';

class MembershipNameScreen extends StatefulWidget {
  const MembershipNameScreen({super.key});

  @override
  State<MembershipNameScreen> createState() => _MembershipNameScreenState();
}

class _MembershipNameScreenState extends State<MembershipNameScreen> {
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
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "성함이 어떻게\n되시나요?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: "IBMPlexSansKRRegular",
                  ),
                ),
                SizedBox(height: 60),
                MembershipInputContainer(
                  width: 300,
                  height: 70,
                  hintText: "사용자님의 이름을 입력하세요.",
                ),
                SizedBox(height: 40),
                MembershipNextButton(
                  destination: MembershipIdpwScreen(),
                ),
                SizedBox(height: 80),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
