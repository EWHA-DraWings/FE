// 웹소켓을 위해 추가
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sodam/models/login_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/calendar/diary_calendar_screen.dart';
import 'package:sodam/screens/chat/diary_chat_screen2.dart';
import 'package:sodam/screens/chat/memory_chat/memory_chat_screen.dart';
import 'package:sodam/screens/report/report_main_screen.dart';
import 'package:sodam/widgets/logout_button_widget.dart';
import 'package:sodam/widgets/main_page_button.dart';
// 웹소켓 채널 추가

class MainScreen extends StatefulWidget {
  final bool isGuardian;
  const MainScreen({
    super.key,
    required this.isGuardian,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // 사용자 타입을 결정하는 변수(사용자 : false, 보호자: true)

  @override
  Widget build(BuildContext context) {
    final loginDataProvider =
        Provider.of<LoginDataProvider>(context, listen: false);
    final token = loginDataProvider.loginData?.token; // 토큰 값 가져오기
    final name = loginDataProvider.loginData?.name; //사용자 이름

    print("Token at MainScreen: $token"); // MainScreen에서 토큰 출력
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [
            //     Pallete.mainBlue, // 시작 색상 (블루)
            //     Pallete.mainWhite,
            //     Pallete.mainWhite // 끝 색상 (화이트)
            //   ],
            // ),
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
                    color: Color.fromARGB(255, 168, 186, 181),
                    fontFamily: "Gugi",
                    height: 1,
                  ),
                ),
                const Text(
                  "나만의 작은 이야기",
                  style: TextStyle(
                    fontSize: 21,
                    color: Color.fromARGB(255, 130, 130, 130),
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
                      //destination: const DiaryChatScreen2(),
                      destination: const DiaryChatScreen2(),
                      text: "대화하기",
                      backColor: Pallete.mainBlue,
                      iconPath: "lib/assets/images/chat.png",
                      isGuardian: widget.isGuardian,
                    ),
                    const SizedBox(width: 20),
                    MainPageButton(
                      destination: const DiaryCalendarScreen(),
                      text: "일기장",
                      backColor: Pallete.sodamButtonGreen,
                      iconPath: "lib/assets/images/diary.png",
                      isGuardian: widget.isGuardian,
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MainPageButton(
                      destination: ReportMainScreen(
                        name: name ?? '사용자',
                      ),
                      text: "리포트",
                      backColor: Pallete.sodamButtonPurple,
                      iconPath: "lib/assets/images/report.png",
                      isGuardian: widget.isGuardian,
                    ),
                    const SizedBox(width: 20),
                    MainPageButton(
                      destination: const MemoryChatScreen(),
                      text: "기억 테스트",
                      backColor: Pallete.sodamButtonPink,
                      iconPath: "lib/assets/images/memory.png",
                      isGuardian: widget.isGuardian,
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
