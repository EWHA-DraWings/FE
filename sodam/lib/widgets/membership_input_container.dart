import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

class MembershipInputContainer extends StatelessWidget {
  //이 위젯은 너비, 높이와 hintText를 지정할 수 있는 입력 컨테이너.
  final double width;
  final double height;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;

  const MembershipInputContainer({
    super.key,
    required this.width,
    required this.height,
    required this.hintText,
    required this.controller,
    this.obscureText = false, //false로 초기화
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // 고정된 너비
      height: height, // 고정된 높이
      decoration: BoxDecoration(
        color: Pallete.sodamYellow.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        //TextField => TextFormField 로 유효성 검사가 용이하게 바꿈.
        controller: controller,
        obscureText: obscureText,
        validator: validator,
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
