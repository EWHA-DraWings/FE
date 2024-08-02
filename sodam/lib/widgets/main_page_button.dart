import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

class MainPageButton extends StatelessWidget {
  final Widget destination; // destination : 넘어갈 다음 화면
  final String text;
  final String iconPath; // 아이콘 이미지의 경로
  final bool enabled; // 버튼 활성화 상태를 제어하는 매개변수

  const MainPageButton({
    super.key,
    required this.destination,
    required this.text,
    required this.iconPath, // 아이콘 이미지 경로를 받는 추가적인 매개변수
    this.enabled = true, // 기본값은 활성화 상태
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 75,
      child: GestureDetector(
        onTap: enabled
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => destination), // 다음 화면
                );
              }
            : null, // 비활성화 상태일 때 클릭할 수 없게 설정
        child: Container(
          decoration: BoxDecoration(
            color:
                enabled ? Colors.white : Colors.grey.withOpacity(0.5), // 버튼 배경색
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Pallete.sodamBeige, // 테두리 색상
              width: 6, // 테두리 두께
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 40),
              Baseline(
                baseline: 42, // 아이콘 높이에 맞춰 조정
                baselineType: TextBaseline.alphabetic,
                child: Image.asset(
                  iconPath,
                  height: 40, // 아이콘의 높이
                ),
              ),
              const SizedBox(width: 30), // 아이콘과 텍스트 사이의 간격
              Baseline(
                baseline: 42, // 텍스트의 기준선 높이에 맞춰 조정
                baselineType: TextBaseline.alphabetic,
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 40,
                    color: enabled
                        ? Colors.black
                        : Colors.black.withOpacity(0.8), // 비활성화 상태에서 텍스트 색상
                    fontFamily: "DoHyeon",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
