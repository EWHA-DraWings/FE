import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

class UserRegisterPhoneScreen extends StatelessWidget {
  const UserRegisterPhoneScreen({super.key});

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
              '보호자의 연락처를\n입력해주세요.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              '보호자 연락처 정보는\n보호자 계정과\n연결 시 사용됩니다.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            const Padding(
              //이름 입력창
              padding: EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 20,
              ),
              child: TextField(
                decoration: InputDecoration(
                  labelText: '010-xxxx-xxxx',
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Pallete.sodamBeige.withOpacity(0.5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: const Text(
                '가입하기',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
