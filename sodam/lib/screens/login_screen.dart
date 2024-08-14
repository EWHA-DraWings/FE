import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sodam/models/guardian_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/main_screen.dart';
import 'package:sodam/widgets/login_input_container.dart';
import 'package:sodam/widgets/membership_input_container.dart';
import 'package:sodam/widgets/membership_next_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.sodamGreen,
      appBar: AppBar(
        backgroundColor: Pallete.sodamGreen,
        foregroundColor: Pallete.sodamDarkPink, //글씨 색
        title: const Text(
          "로그인",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            fontFamily: "PoorStory",
          ),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            SizedBox(
              height: 5,
            ),
            Text(
              '로그인',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Pallete.sodamDarkPink,
                fontFamily: "IBMPlexSansKRBold",
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              //id
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '아이디',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Pallete.sodamBrown,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  LoginInputContainer(width: 220, height: 60, hintText: ""),
                ],
              ),
            ),
            Padding(
              //password
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '비밀번호',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Pallete.sodamBrown,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  LoginInputContainer(width: 220, height: 60, hintText: ""),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            // MembershipNextButton(//로그인 하기 버튼 새로 구현 필요.
            //     destination: MainScreen(
            //   isGuardian: true,
            // )), //여기 바꿔줘야 됨
          ],
        ),
      ),
    );
  }
}
