import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/register_user/register_phone_screen.dart';

class UserRegisterIdPwScreen extends StatelessWidget {
  const UserRegisterIdPwScreen({super.key});

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
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '사용할 아이디와\n비밀번호를\n입력해주세요.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              //id 입력창
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                decoration: InputDecoration(
                  labelText: '아이디',
                  labelStyle: TextStyle(
                    fontSize: 30,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              //비밀번호 입력창
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  labelStyle: TextStyle(
                    fontSize: 30,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              //비밀번호 확인 입력창
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                decoration: InputDecoration(
                  labelText: '비밀번호 확인',
                  labelStyle: TextStyle(
                    fontSize: 30,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    //route:stateless widget을 애니메이션 효과로 감싸서 스크린처럼 보이게 함
                    builder: (context) =>
                        const UserRegisterPhoneScreen(), //보호자 전화번호 입력 화면으로 전환
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
