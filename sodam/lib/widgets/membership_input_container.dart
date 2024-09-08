import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

class MembershipInputContainer extends StatelessWidget {
  //이 위젯은 높이와 hintText를 지정할 수 있는 입력 컨테이너.
  final double height;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;

  const MembershipInputContainer({
    super.key,
    required this.height,
    required this.controller,
    this.obscureText = false, //false로 초기화
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.8,
      height: height,
      decoration: BoxDecoration(
        color: Pallete.sodamYellow.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        //TextField => TextFormField 로 유효성 검사가 용이하게 바꿈.
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
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
