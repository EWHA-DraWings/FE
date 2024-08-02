import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/register_user/register_id_pw_screen.dart';

class UserRegisterNameScreen extends StatelessWidget {
  const UserRegisterNameScreen({super.key});

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
            fontFamily: "PoorStory",
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '성함이 어떻게\n되시나요?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.normal,
                fontFamily: "IBMPlexSansKRRegular",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              //이름 입력창
              padding: EdgeInsets.all(50),
              child: TextField(
                decoration: InputDecoration(
                  labelText: '이름',
                  labelStyle: TextStyle(
                    fontSize: 30,
                    fontFamily: "PoorStory",
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    //route:stateless widget을 애니메이션 효과로 감싸서 스크린처럼 보이게 함
                    builder: (context) =>
                        const UserRegisterIdPwScreen(), //아이디 비번 입력 화면으로 전환
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Pallete.sodamBeige.withOpacity(0.5),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text(
                  '다음',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontFamily: "PoorStory",
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
