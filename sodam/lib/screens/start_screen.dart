//시작화면

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/Guardian_membership/membership_screen.dart';
import 'package:sodam/screens/login_screen.dart';
import 'package:sodam/screens/report/report_calendar_screen.dart';
import 'package:sodam/screens/report/report_result_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.sodamGreen,
      appBar: AppBar(
        backgroundColor: Pallete.sodamGreen,
        foregroundColor: Pallete.sodamDarkPink, //글씨 색
        title: const Row(
          children: [
            SizedBox(
              //제목 앞 공간
              width: 10,
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(70), //외부간격
              child: const Column(
                children: [
                  Text(
                    "소담",
                    style: TextStyle(
                      color: Pallete.sodamBeige,
                      fontSize: 95,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Gugi",
                    ),
                  ),
                  Text(
                    "나만의 작은 이야기",
                    style: TextStyle(
                      color: Pallete.sodamDarkPink,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Gugi",
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(), //로그인 화면으로 전환
                  ),
                );
              },
              child: Container(
                width: 300,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Pallete.sodamBeige, // 테두리 색상
                    width: 10, // 테두리 두께
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                alignment: AlignmentDirectional.center,
                child: const Text(
                  '로그인',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Pallete.sodamBrown,
                    fontFamily: "PoorStory",
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MembershipScreen(),
                    //const RegisterTypeScreen(), //회원 가입 화면(YE ver)으로 전환
                  ),
                );
              },
              child: Container(
                width: 300,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Pallete.sodamBeige, // 테두리 색상
                    width: 10, // 테두리 두께
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                alignment: AlignmentDirectional.center,
                child: const Text(
                  '회원가입',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Pallete.sodamBrown,
                    fontFamily: "PoorStory",
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ReportCalendarScreen(), //리포트 달력 화면으로 전환
                  ),
                );
              },
              child: const Text(
                '리포트(달력화면)테스트용',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Pallete.sodamBrown,
                  fontFamily: "PoorStory",
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ReportResultScreen(), //리포트 달력 화면으로 전환(const 일시적으로 지움)
                  ),
                );
              },
              child: const Text(
                '리포트 결과 테스트용',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Pallete.sodamBrown,
                  fontFamily: "PoorStory",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
