import 'dart:async';
import 'dart:convert';
// 웹소켓을 위해 추가
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sodam/global.dart';
import 'package:sodam/models/emotion_data.dart';
import 'package:sodam/models/login_data.dart';
import 'package:sodam/models/report_data.dart';
import 'package:http/http.dart' as http;

import 'package:sodam/pallete.dart';
import 'package:sodam/screens/calendar/diary_calendar_screen.dart';
import 'package:sodam/screens/chat/diary_chat_screen2.dart';
import 'package:sodam/screens/chat/memory_chat/memory_chat_screen.dart';
import 'package:sodam/screens/chat/websocket_provider.dart';
import 'package:sodam/screens/report/report_main_screen.dart';
import 'package:sodam/screens/self_diagnosis/guardian_diagnosis_screen.dart';
import 'package:sodam/screens/self_diagnosis/user_diagnosis_screen.dart';
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
  //리포트 가져오기(리포트 1개 리턴)
  Future<dynamic> getTodayReport(BuildContext context) async {
    //오늘 날짜
    String today = '2024-10-07';

    final loginDataProvider =
        Provider.of<LoginDataProvider>(context, listen: false);
    final token = loginDataProvider.loginData?.token;

    //일기 확인 및 리포트 생성
    final url = Uri.parse('http://${Global.ipAddr}:3000/api/reports/$today');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      //json data를 Map으로 디코딩
      final report = jsonDecode(response.body);
      print(report);
      //생성.조회한 리포트 가져오기
      return report;
    } else if (response.statusCode == 404) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('해당 날짜의 일기가 없습니다. 일기가 존재하는 날짜의 리포트만 조회 가능합니다.')),
      );
      return null; // 404일 때 null 반환
    } else {
      //500
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('500: 리포트 조회에 실패했습니다.')),
      );
      return null; // 500일 때도 null 반환
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginDataProvider =
        Provider.of<LoginDataProvider>(context, listen: false);
    final token = loginDataProvider.loginData?.token; // 토큰 값 가져오기
    final name = loginDataProvider.loginData?.name; // 사용자 이름

    print("Token at MainScreen: $token"); // MainScreen에서 토큰 출력
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
                      //destination: const DiaryChatScreen2(),
                      destination: const MemoryChatScreen(),
                      text: "대화하기",
                      backColor: Pallete.mainBlue,
                      iconPath: "lib/assets/images/chat.png",
                      isGuardian: widget.isGuardian,
                    ),
                    const SizedBox(width: 20),
                    MainPageButton(
                      destination: const DiaryCalendarScreen(),
                      text: "일기장",
                      backColor: Pallete.sodamButtonDarkGreen,
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
                      text: "리포트",
                      backColor: Pallete.sodamButtonPurple,
                      iconPath: "lib/assets/images/report.png",
                      isGuardian: widget.isGuardian,
                      onTap: () async {
                        // 오늘 리포트 생성 확인
                        ReportData? todaysReport =
                            await getTodayReport(context);
                        // 리포트 화면 이동
                        if (todaysReport != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReportMainScreen(
                                name: name ?? '사용자',
                                daysPast: 5, // 일단 임의로 넣은 숫자
                                todaysReport: todaysReport,
                              ),
                            ),
                          );
                        } else {
                          // 리포트가 없는 경우 처리
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('오늘의 리포트를 불러오지 못했습니다.')),
                          );
                        }
                      },
                    ),
                    const SizedBox(width: 20),
                    MainPageButton(
                      destination: widget.isGuardian
                          ? const GuardianDiagnosisScreen()
                          : const UserDiagnosisScreen(),
                      text: "자가진단",
                      backColor: Pallete.sodamButtonSkyBlue,
                      iconPath: "lib/assets/images/self_diagnosis.png",
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
