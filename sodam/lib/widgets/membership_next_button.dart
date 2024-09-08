import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

class MembershipNextButton extends StatelessWidget {
  final VoidCallback onPressed;

  const MembershipNextButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255), // 버튼 배경 색상
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // 버튼 모서리 둥글기
          ),
        ),
        child: const Text(
          '다음',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'IBMPlexSansKRBold',
          ),
        ),
      ),
    );
  }
}
