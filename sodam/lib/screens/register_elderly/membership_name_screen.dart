import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/register_elderly/membership_idpw_screen.dart';
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
                "성함이 어떻게\n되시나요?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: "IBMPlexSansKRRegular",
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
                    height: 70,
                    hintText: "사용자님의 이름을 입력하세요.",
                  ),
                  SizedBox(height: 40),
                  MembershipNextButton(
                    destination: MembershipIdpwScreen(),
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
