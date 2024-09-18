import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

class SigninElderlyNextButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SigninElderlyNextButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.8,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Pallete.mainWhite,
          backgroundColor: Pallete.mainBlue, // 버튼 배경 색상
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // 버튼 모서리 둥글기
          ),
        ),
        child: const Text(
          '다음',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'IBMPlexSansKRRegular',
          ),
        ),
      ),
    );
  }
}
