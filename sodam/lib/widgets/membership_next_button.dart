import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

class MembershipNextButton extends StatelessWidget {
  final Widget destination; //destination : 넘어갈 다음 화면

  const MembershipNextButton({
    super.key,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination), // 다음 화면
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Pallete.sodamBeige, // 버튼 배경 색상
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // 버튼 모서리 둥글기
        ),
      ),
      child: const Text(
        '다음',
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'IBMPlexSansKRRegular',
        ),
      ),
    );
  }
}
