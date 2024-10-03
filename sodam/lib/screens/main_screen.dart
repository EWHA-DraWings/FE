import 'package:flutter/material.dart';
import 'package:sodam/models/emotion_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/calendar/diary_calendar_screen.dart';
import 'package:sodam/screens/chat/diary_chat_screen.dart';
import 'package:sodam/screens/calendar/report_calendar_screen.dart';
import 'package:sodam/screens/report/report_main_screen.dart';
import 'package:sodam/screens/self_diagnosis/guardian_diagnosis_screen.dart';
import 'package:sodam/screens/self_diagnosis/user_diagnosis_screen.dart';
import 'package:sodam/widgets/logout_button_widget.dart';
import 'package:sodam/widgets/main_page_button.dart';

class MainScreen extends StatelessWidget {
  final bool isGuardian; // 사용자 타입을 결정하는 변수(사용자 : false, 보호자: true)
  const MainScreen({super.key, required this.isGuardian});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Pallete.mainBlue, // 시작 색상 (블루)
              Pallete.mainWhite,
              Pallete.mainWhite // 끝 색상 (화이트)
            ],
          ),
        ),
        child: Column(
          children: [
            // 상단 텍스트 영역
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.27,
                ),
                const Text(
                  "소담",
                  style: TextStyle(
                    fontSize: 90,
                    color: Pallete.mainWhite,
                    fontFamily: "Gugi",
                    height: 1,
                  ),
                ),
                const Text(
                  "나만의 작은 이야기",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 29, 46, 105),
                    fontFamily: "Gugi",
                  ),
                ),
              ],
            ),

            // 중앙 버튼 영역
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MainPageButton(
                      destination: const DiaryChatScreen(),
                      text: "대화하기",
                      backColor: Pallete.mainBlue,
                      iconPath: "lib/assets/images/chat.png",
                      isGuardian: isGuardian,
                    ),
                    const SizedBox(width: 20),
                    MainPageButton(
                      destination: const DiaryCalendarScreen(),
                      text: "일기장",
                      backColor: Pallete.sodamButtonDarkGreen,
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
                      destination: ReportMainScreen(
                        name: '홍길동',
                        daysPast: 5,
                        emotions: [
                          EmotionData(emotion: '슬픔', percentage: 50.0),
                          EmotionData(emotion: '행복', percentage: 40.0),
                          EmotionData(emotion: '분노', percentage: 10.0),
                        ],
                      ),
                      text: "리포트",
                      backColor: Pallete.sodamButtonPurple,
                      iconPath: "lib/assets/images/report.png",
                      isGuardian: isGuardian,
                    ),
                    const SizedBox(width: 20),
                    MainPageButton(
                      destination: isGuardian
                          ? const GuardianDiagnosisScreen()
                          : const UserDiagnosisScreen(),
                      text: "자가진단",
                      backColor: Pallete.sodamButtonSkyBlue,
                      iconPath: "lib/assets/images/self_diagnosis.png",
                      isGuardian: isGuardian,
                    ),
                  ],
                ),
              ],
            ),

            // 하단 로그아웃 버튼 영역
            const Expanded(
              // 이 부분이 하단에 남은 공간을 차지하도록 함
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 18),
                  child: LogoutButtonWidget(), //로그아웃 버튼
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
