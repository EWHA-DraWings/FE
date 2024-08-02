//회원가입 시 사용자 또는 보호자 선택하는 화면
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/login_screen.dart';

import 'register_user/register_name_screen.dart';

class RegisterTypeScreen extends StatelessWidget {
  const RegisterTypeScreen({super.key});

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
            Text(
              "회원가입",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                fontFamily: "PoorStory",
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '가입 유형을\n선택해 주세요.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 45,
                fontFamily: "IBMPlexSansKRRegular",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              //화면전환용
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    //route:stateless widget을 애니메이션 효과로 감싸서 스크린처럼 보이게 함
                    builder: (context) =>
                        const UserRegisterNameScreen(), //이름 입력 화면으로 전환
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Pallete.sodamBeige.withOpacity(0.5),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                child: const Text(
                  '사용자',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontFamily: "PoorStory",
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              //화면전환용
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    //route:stateless widget을 애니메이션 효과로 감싸서 스크린처럼 보이게 함
                    builder: (context) =>
                        const UserRegisterNameScreen(), //이름 입력 화면으로 전환
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Pallete.sodamBeige.withOpacity(0.5),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                child: const Text(
                  '보호자',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontFamily: "PoorStory",
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              //로그인
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(), //로그인 화면으로 전환
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Pallete.sodamPink.withOpacity(0.7),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: const Text(
                  '계정이 있어요!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontFamily: "IBMPlexSansKRRegular",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
