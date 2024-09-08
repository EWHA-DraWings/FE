import 'package:flutter/material.dart';
import 'package:sodam/models/elderly_data.dart';
import 'package:sodam/models/guardian_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/Guardian_membership/membership_name_screen.dart';
import 'package:sodam/screens/register_user/register_name_screen.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({super.key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  void _guardianNextScreen(String role) {
    // GuardianData 객체를 생성합니다.
    final guardianData = GuardianData(role: role);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MembershipNameScreen(data: guardianData),
      ),
    );
  }

  void _elderlyNextScreen(String role) {
    // ElderlyData 객체를 생성합니다.
    final elderlyData = ElderlyData(role: role);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MembershipNameElderlyScreen(data: elderlyData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
            fontFamily: "IBMPlexSansKRBold",
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
                    _elderlyNextScreen(
                        "elderly"); // Set role to "elderly" and navigate
                  },
                  child: Container(
                    width: screenWidth * 0.8,
                    height: 70,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF8F74),
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 11,
                        horizontal: 100,
                      ),
                      child: Center(
                        child: Text(
                          "사용자",
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: "IBMPlexSansKRBold",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _guardianNextScreen(
                        "guardian"); // Set role to "guardian" and navigate
                  },
                  child: Container(
                    width: screenWidth * 0.8,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Pallete.sodamNewGreen,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 11,
                        horizontal: 100,
                      ),
                      child: Center(
                        child: Text(
                          "보호자",
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: "IBMPlexSansKRBold",
                          ),
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
