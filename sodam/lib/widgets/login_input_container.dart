import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

class LoginInputContainer extends StatelessWidget {
  //이 위젯은 너비, 높이와 hintText를 지정할 수 있는 입력 컨테이너.
  final double width;
  final double height;
  final String hintText;

  const LoginInputContainer({
    super.key,
    required this.width,
    required this.height,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey, // 테두리 색상 블랙으로 설정
          width: 2.0, // 테두리 두께 설정
        ),
      ),
      child: TextField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 25,
            fontFamily: 'IBMPlexSansKRRegular',
            color: Colors.grey[600],
          ),
          contentPadding: EdgeInsets.only(top: height / 5),
        ),
        style: const TextStyle(
          fontSize: 20,
          fontFamily: 'IBMPlexSansKRRegular',
        ),
      ),
    );
  }
}
