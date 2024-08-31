import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

class MainPageButton extends StatefulWidget {
  final Widget destination; // destination : 넘어갈 다음 화면
  final String text;
  final Color backColor; //버튼 배경색
  final String iconPath; // 아이콘 이미지의 경로
  final bool isGuardian; // 버튼 활성화 상태를 제어하는 매개변수

  const MainPageButton({
    super.key,
    required this.destination,
    required this.text,
    required this.backColor,
    required this.iconPath, // 아이콘 이미지 경로를 받는 추가적인 매개변수
    required this.isGuardian,
  });

  @override
  State<MainPageButton> createState() => _MainPageButtonState();
}

class _MainPageButtonState extends State<MainPageButton> {
  bool isHovered = false; //클릭 애니메이션
  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDisabled =
        widget.isGuardian && (widget.text == "대화하기" || widget.text == "일기장");

    return Column(
      children: [
        GestureDetector(
          onTap: !isDisabled
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => widget.destination), // 다음 화면
                  );
                }
              : null, // 비활성화 상태일 때 클릭할 수 없게 설정
          onTapDown: (_) {
            setState(() {
              isHovered = true;
            });
          },
          onTapUp: (_) {
            setState(() {
              isHovered = false;
            });
          },
          onTapCancel: () {
            setState(() {
              isHovered = false;
            });
          },
          child: AnimatedScale(
            scale: isHovered ? 1.02 : 1.0,
            duration: const Duration(milliseconds: 50),
            curve: Curves.easeInOut,
            child: Container(
              width: screenWidth * 0.38,
              height: screenWidth * 0.38,
              decoration: BoxDecoration(
                color: !isDisabled
                    ? widget.backColor
                    : Colors.grey.withOpacity(0.5), // 버튼 배경색
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6), // 그림자 색상 및 투명도 설정
                    spreadRadius: 3, // 그림자 확산 정도
                    blurRadius: 7, // 그림자 흐림 정도
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  widget.iconPath,
                  width: 70,
                  color: !isDisabled ? null : Colors.grey, // 비활성화 시 아이콘 색상 변경
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10), // 아이콘과 텍스트 사이에 간격 추가
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 50),
          style: TextStyle(
            color: !isDisabled
                ? Pallete.sodamBrown
                : Colors.grey, // 비활성화 시 텍스트 색상 변경
            fontSize: isHovered ? 21 : 20,
            fontFamily: "IBMPlexSansKRBold",
          ),
          child: Text(
            widget.text,
          ),
        ),
      ],
    );
  }
}
