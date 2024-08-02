import 'package:flutter/material.dart';

class DiaryButtonWidget extends StatelessWidget {
  final String text;
  final Color backgroundColor;

  const DiaryButtonWidget({
    super.key,
    required this.text,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // 버튼 1의 동작
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, // 버튼 배경색
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // 버튼의 모서리 둥글기
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: "IBMPlexSansKRBold",
            color: Colors.black, // 텍스트 색상
          ),
        ),
      ),
    );
  }
}
