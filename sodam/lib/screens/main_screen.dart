import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/register_elderly/membership_idpw_screen.dart';
import 'package:sodam/widgets/main_page_button.dart';

//GuardianMainScreen(isGuardian : true); 면 보호자 화면 랜더링, false면 사용자 화면 랜더링.

class MainScreen extends StatelessWidget {
  final bool isGuardian; // 사용자 타입을 결정하는 변수

  const MainScreen({super.key, required this.isGuardian});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Pallete.sodamGreen,
        body: Column(
          children: [
            const Flexible(
              flex: 3,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      "소담",
                      style: TextStyle(
                        fontSize: 90,
                        color: Pallete.sodamBeige,
                        fontFamily: "Gugi",
                      ),
                    ),
                    Text(
                      "나만의 작은 이야기",
                      style: TextStyle(
                        fontSize: 20,
                        color: Pallete.sodamPink,
                        fontFamily: "Gugi",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Center(
                child: Column(
                  children: [
                    _buildButton(
                      context,
                      "대화하기",
                      "lib/assets/images/chatbot.png",
                      isGuardian,
                    ),
                    const SizedBox(height: 25),
                    _buildButton(
                      context,
                      "일기장",
                      "lib/assets/images/book.png",
                      isGuardian,
                    ),
                    const SizedBox(height: 25),
                    _buildButton(
                      context,
                      "리포트",
                      "lib/assets/images/score.png",
                      isGuardian,
                    ),
                    const SizedBox(height: 25),
                    _buildButton(
                      context,
                      "자가진단",
                      "lib/assets/images/self-examination.png",
                      isGuardian,
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(),
            ),
          ],
        ));
  }

  Widget _buildButton(
    BuildContext context,
    String text,
    String iconPath,
    bool isGuardian,
  ) {
    bool isDisabled = isGuardian && (text == "대화하기" || text == "일기장");

    return Stack(
      children: [
        MainPageButton(
          destination: const MembershipIdpwScreen(),
          text: text,
          iconPath: iconPath,
          enabled: !isDisabled, // 버튼 비활성화 여부
        ),
        if (isDisabled)
          Positioned.fill(
            child: Container(
              color: Colors.grey.withOpacity(0.5), // 반투명 회색 오버레이
            ),
          ),
      ],
    );
  }
}
