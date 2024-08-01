import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "소담",
              style: TextStyle(
                color: Pallete.sodamBeige,
                fontSize: 95,
                fontWeight: FontWeight.w400,
                fontFamily: "Gugi",
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              '로그인',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Pallete.sodamDarkPink,
                fontFamily: "IBMPlexSansKRBold",
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Padding(
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
                  SizedBox(
                    width: 220,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Pallete.sodamBeige,
                        labelText: '아이디',
                        labelStyle: TextStyle(
                          fontSize: 30,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
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
                  SizedBox(
                    width: 220,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Pallete.sodamBeige,
                        labelText: '비밀번호',
                        labelStyle: TextStyle(
                          fontSize: 30,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
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
                '로그인',
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
