import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/calendar/diary_calendar_screen.dart';
import 'package:sodam/screens/chat/diary_chat_screen.dart';
import 'package:sodam/screens/calendar/report_calendar_screen.dart';
import 'package:sodam/screens/self_diagnosis/guardian_diagnosis_screen.dart';
import 'package:sodam/screens/self_diagnosis/user_diagnosis_screen.dart';
import 'package:sodam/widgets/logout_button_widget.dart';
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
          Flexible(
            flex: 2,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.27,
                  ),
                  const Text(
                    "소담",
                    style: TextStyle(
                        fontSize: 90,
                        color: Pallete.sodamLightBrown,
                        fontFamily: "Gugi",
                        height: 1),
                  ),
                  const Text(
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
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MainPageButton(
                        destination: const DiaryChatScreen(),
                        text: "대화하기",
                        backColor: Pallete.sodamOrange,
                        iconPath: "lib/assets/images/chat.png",
                        isGuardian: isGuardian,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      MainPageButton(
                        destination: const DiaryCalendarScreen(),
                        text: "일기장",
                        backColor: Pallete.sodamNewGreen,
                        iconPath: "lib/assets/images/diary.png",
                        isGuardian: isGuardian,
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
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
                  const Spacer(), // 남은 공간을 채워서 버튼을 아래로 밀어냄
                  const Padding(
                    padding: EdgeInsets.only(bottom: 18),
                    child: LogoutButtonWidget(), //로그아웃 버튼
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
