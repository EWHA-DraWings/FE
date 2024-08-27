import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/Guardian_membership/membership_idpw_screen.dart';
import 'package:sodam/screens/chat/diary_chat_screen.dart';
import 'package:sodam/screens/diary_screen.dart';
import 'package:sodam/screens/report/report_calendar_screen.dart';
import 'package:sodam/screens/self_diagnosis/guardian_diagnosis_screen.dart';
import 'package:sodam/screens/self_diagnosis/user_diagnosis_screen.dart';
import 'package:sodam/widgets/main_page_button.dart';

//GuardianMainScreen(isGuardian : true); 면 보호자 화면 랜더링, false면 사용자 화면 랜더링.

class MainScreen extends StatelessWidget {
  final bool isGuardian; // 사용자 타입을 결정하는 변수(사용자 : false, 보호자: true)
  const MainScreen({super.key, required this.isGuardian});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.sodamIvory,
      body: Column(
        children: [
          const Flexible(
            flex: 3,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    "소담",
                    style: TextStyle(
                      fontSize: 90,
                      color: Pallete.sodamLightBrown,
                      fontFamily: "Gugi",
                    ),
                  ),
                  Text(
                    "나만의 작은 이야기",
                    style: TextStyle(
                      fontSize: 20,
                      color: Pallete.sodamNewDarkPink,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MainPageButton(
                        destination: const DiaryChatScreen(), //화면 수정 필요
                        text: "대화하기",
                        backColor: Pallete.sodamOrange,
                        iconPath: "lib/assets/images/chat.png",
                        isGuardian: isGuardian,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      MainPageButton(
                        destination: const DiaryScreen(),
                        text: "일기장",
                        backColor: Pallete.sodamNewGreen,
                        iconPath: "lib/assets/images/diary.png",
                        isGuardian: isGuardian,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MainPageButton(
                        destination: const ReportCalendarScreen(),
                        text: "리포트",
                        backColor: Pallete.sodamNewDarkPink,
                        iconPath: "lib/assets/images/report.png",
                        isGuardian: isGuardian,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      MainPageButton(
                        destination: isGuardian
                            ? const GuardianDiagnosisScreen()
                            : const UserDiagnosisScreen(),
                        text: "자가진단",
                        backColor: Pallete.sodamYellow,
                        iconPath: "lib/assets/images/self_diagnosis.png",
                        isGuardian: isGuardian,
                      ),
                    ],
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
      ),
    );
  }

  // Widget _buildButton( //사용자인지 보호자인지에 따라 다르게 랜더링하도록 구현한 함수..
  //   BuildContext context,
  //   String text,
  //   Color backColor,
  //   String iconPath,
  //   bool isGuardian,
  // ) {
  //   bool isDisabled = isGuardian && (text == "대화하기" || text == "일기장");

  //   return Stack(
  //     children: [
  //       MainPageButton(
  //         destination: MainScreen(
  //           isGuardian: isGuardian,
  //         ), //나중에 수정 필요 . destination을 변수로 받아서 각 버튼에 맞게 목적지로 이동
  //         text: text,
  //         backColor: backColor,
  //         iconPath: iconPath,
  //         enabled: !isDisabled, // 버튼 비활성화 여부
  //       ),
  //     ],
  //   );
  // }
}
