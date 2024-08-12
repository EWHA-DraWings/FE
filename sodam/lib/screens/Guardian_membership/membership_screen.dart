import 'package:flutter/material.dart';
import 'package:sodam/models/guardian_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/Guardian_membership/membership_name_screen.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({super.key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  void _navigateToNextScreen(String role) {
    // GuardianData 객체를 생성합니다.
    final guardianData = GuardianData(role: role);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MembershipNameScreen(data: guardianData),
      ),
    );
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              textAlign: TextAlign.center,
              "가입유형을 \n선택해주세요.",
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'IBMPlexSansKRRegular',
              ),
            ),
            const SizedBox(height: 60),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _navigateToNextScreen(
                        "elderly"); // Set role to "elderly" and navigate
                  },
                  child: Container(
                    width: 300,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Pallete.sodamBeige.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 11,
                        horizontal: 100,
                      ),
                      child: Text(
                        "사용자",
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: "PoorStory",
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _navigateToNextScreen(
                        "guardian"); // Set role to "guardian" and navigate
                  },
                  child: Container(
                    width: 300,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Pallete.sodamBeige.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 11,
                        horizontal: 100,
                      ),
                      child: Text(
                        "보호자",
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: "PoorStory",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
