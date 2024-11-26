import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

class MainPageButton extends StatefulWidget {
  final Widget? destination; // destination : 넘어갈 다음 화면
  final String text;
  final Color backColor; // 버튼 배경색
  final String iconPath; // 아이콘 이미지의 경로
  final bool isGuardian; // 버튼 활성화 상태를 제어하는 매개변수
  final Function()? onTap; // Tap 핸들러. => 대화하기 버튼

  const MainPageButton({
    super.key,
    this.destination,
    required this.text,
    required this.backColor,
    required this.iconPath,
    required this.isGuardian,
    this.onTap,
  });

  @override
  State<MainPageButton> createState() => _MainPageButtonState();
}

class _MainPageButtonState extends State<MainPageButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    // Define the colorTween to lower the saturation of the background color
    _colorAnimation = ColorTween(
      begin: widget.backColor,
      end: _desaturateColor(widget.backColor), // Desaturate the original color
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to desaturate the color by reducing its saturation
  Color _desaturateColor(Color color) {
    final hsl = HSLColor.fromColor(color);
    final desaturatedHsl =
        hsl.withSaturation(hsl.saturation * 0.8); // Reduce saturation
    return desaturatedHsl.toColor();
  }

  void _onTap() {
    if (!widget.isGuardian || widget.text != "대화하기") {
      _controller.forward().then((_) {
        _controller.reverse().then((_) {
          if (widget.onTap != null) {
            widget.onTap!(); // onTap을 호출
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => widget.destination!, // 다음 화면
              ),
            );
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDisabled =
        widget.isGuardian && (widget.text == "대화하기" || widget.text == "일기장");

    return Column(
      children: [
        GestureDetector(
          onTap: _onTap,
          onTapDown: (_) => _controller.forward(),
          onTapUp: (_) => _controller.reverse(),
          onTapCancel: () => _controller.reverse(),
          child: AnimatedBuilder(
            animation: _colorAnimation,
            builder: (context, child) {
              return Container(
                width: screenWidth * 0.38,
                height: screenWidth * 0.38,
                decoration: BoxDecoration(
                  color: isDisabled
                      ? const Color.fromARGB(255, 135, 137, 155)
                          .withOpacity(0.5)
                      : _colorAnimation.value,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: isDisabled
                          ? Colors.transparent
                          : Colors.white.withOpacity(0.5), // 그림자 색상 및 투명도 설정
                      spreadRadius: 1, // 그림자 확산 정도
                      blurRadius: 10, // 그림자 흐림 정도
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    widget.iconPath,
                    width: 70,
                    color: isDisabled
                        ? const Color.fromARGB(255, 181, 181, 201)
                        : null, // 비활성화 시 아이콘 색상 변경
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10), // 아이콘과 텍스트 사이에 간격 추가
        Text(
          widget.text,
          style: TextStyle(
            color: isDisabled
                ? const Color.fromARGB(255, 162, 164, 186)
                : const Color.fromARGB(255, 93, 93, 96), // 비활성화 시 텍스트 색상 변경
            fontSize: 20,
            fontFamily: "IBMPlexSansKRBold",
          ),
        ),
      ],
    );
  }
}
