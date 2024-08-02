import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/Guardian_membership/memebership_extrainfo_screen.dart';
import 'package:sodam/widgets/membership_input_container.dart';
import 'package:sodam/widgets/membership_next_button.dart';

class MembershipIdpwScreen extends StatefulWidget {
  const MembershipIdpwScreen({super.key});

  @override
  State<MembershipIdpwScreen> createState() => _MembershipIdpwScreenState();
}

class _MembershipIdpwScreenState extends State<MembershipIdpwScreen> {
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
            Text(
              "사용할 아이디와\n비밀번호를\n입력해주세요.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'IBMPlexSansKRRegular',
              ),
            ),
            SizedBox(height: 60),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MembershipInputContainer(
                  width: 300,
                  height: 60,
                  hintText: "아이디",
                ),
                SizedBox(height: 10),
                MembershipInputContainer(
                  width: 300,
                  height: 60,
                  hintText: "비밀번호",
                ),
                SizedBox(height: 40),
                MembershipNextButton(
                  destination: MemebershipExtrainfoScreen(),
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
