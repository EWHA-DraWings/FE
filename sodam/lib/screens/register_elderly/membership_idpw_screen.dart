import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/register_elderly/memebership_extrainfo_screen.dart';
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
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // 좌우 여백 추가
              child: const Align(
                alignment: Alignment.centerLeft, // 왼쪽 정렬
                child: Text(
                  "회원가입",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Gugi",
                    fontWeight: FontWeight.w600,
                    color: Pallete.sodamDarkPink,
                  ),
                ),
              ),
            ),
          ),
          const Flexible(
            flex: 1,
            child: Center(
              child: Text(
                "사용할 아이디와\n비밀번호를\n입력해주세요.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'IBMPlexSansKRRegular',
                ),
              ),
            ),
          ),
          const Flexible(
            flex: 2,
            child: Center(
              child: Column(
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
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(), // 빈 공간
          ),
        ],
      ),
    );
  }
}
