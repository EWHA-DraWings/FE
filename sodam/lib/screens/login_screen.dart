import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

import 'package:sodam/widgets/login_button.dart';
import 'package:sodam/widgets/login_input_container.dart';

import 'package:sodam/widgets/move_to_membership_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Pallete.mainWhite,
      appBar: AppBar(
        backgroundColor: Pallete.mainWhite,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "안녕하세요, 소담이에요!",
                  style: TextStyle(
                    color: Pallete.mainBlack,
                    fontFamily: "IBMPlexSansKRBold",
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "다시 만나 반가워요 :)",
                  style: TextStyle(
                    color: Pallete.mainBlack,
                    fontFamily: "IBMPlexSansKRBold",
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.1,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '아이디',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: "IBMPlexSansKRRegular",
                    color: Pallete.mainBlack,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const LoginInputContainer(width: 220, height: 60, hintText: ""),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '비밀번호',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: "IBMPlexSansKRRegular",
                    color: Pallete.mainBlack,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const LoginInputContainer(width: 220, height: 60, hintText: ""),
            const SizedBox(
              height: 50,
            ),
            const LoginButton(),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "아직 계정이 없으신가요?",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  //MoveToMembershipButton(), ->에러나서 임시 주석처리
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
