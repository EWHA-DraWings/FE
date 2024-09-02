import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth * 0.9,
      height: 58,
      child: ElevatedButton(
        onPressed: () {
          //api 호출하기
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Pallete.sodamYellow, // 버튼 배경 색상
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // 버튼 모서리 둥글기
          ),
        ),
        child: const Text(
          '로그인',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'IBMPlexSansKRBold',
          ),
        ),
      ),
    );
  }
}
