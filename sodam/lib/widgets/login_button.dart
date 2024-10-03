import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:http/http.dart' as http;

class LoginButton extends StatelessWidget {
  final VoidCallback loginButtonPressed;

  const LoginButton({
    super.key,
    required this.loginButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.9,
      height: 59,
      child: ElevatedButton(
        onPressed: () {
          //api 호출하기
          loginButtonPressed();
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Pallete.mainBlack,
          backgroundColor: Pallete.mainBlue, // 버튼 배경 색상
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // 버튼 모서리 둥글기
          ),
        ),
        child: const Text(
          '로그인',
          style: TextStyle(
            color: Pallete.mainWhite,
            fontSize: 20,
            fontFamily: 'IBMPlexSansKRBold',
          ),
        ),
      ),
    );
  }
}
