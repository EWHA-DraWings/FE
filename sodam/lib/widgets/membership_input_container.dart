import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

class MembershipInputContainer extends StatelessWidget {
  //이 위젯은 너비, 높이와 hintText를 지정할 수 있는 입력 컨테이너.
  final double width;
  final double height;
  final String hintText;

  const MembershipInputContainer({
    super.key,
    required this.width,
    required this.height,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // 고정된 너비
      height: height, // 고정된 높이
      decoration: BoxDecoration(
        color: Pallete.sodamBeige.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: TextField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 20,
              fontFamily: 'IBMPlexSansKRRegular',
              color: Colors.grey[600],
            ),
          ),
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'IBMPlexSansKRRegular',
          ),
        ),
      ),
    );
  }
}
