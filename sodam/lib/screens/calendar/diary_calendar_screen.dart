import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sodam/global.dart';
import 'package:sodam/models/login_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/diary_screen.dart';
import 'package:sodam/widgets/title_widget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http; //http 가져오기

class DiaryCalendarScreen extends StatefulWidget {
  const DiaryCalendarScreen({super.key});

  @override
  State<DiaryCalendarScreen> createState() => _DiaryCalendarScreenState();
}

class _DiaryCalendarScreenState extends State<DiaryCalendarScreen>
    with SingleTickerProviderStateMixin {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now(); // 화면에 표시된 날짜
  DateTime? _selectedDay; // 사용자 선택 날짜
  final double calendarFontSize = 20.0;
  late AnimationController _animationController; //애니메이션 컨트롤러. 애니메이션 지속시간 설정
  late Animation<double> _animation; //날짜 선택시 글씨 커지게 하는 애니메이션

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      //초기화
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 1.0, end: 1.3).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleDaySelected(
      DateTime selectedDay, DateTime focusedDay, String? jwtToken) {
    String diaryDate = '';
    if (_selectedDay != selectedDay) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        //2024-10-02 00:00:00.000Z -> 20241002
        diaryDate =
            _selectedDay.toString().split(" ").first.replaceAll('-', '').trim();
        print(diaryDate);
      });
      _animationController.forward().then((_) {
        //약간의 딜레이 후 이동
        Future.delayed(const Duration(milliseconds: 100), () async {
          ///api/diary/date/:date (20240901형식)
          final url = Uri.parse(
              'http://${Global.ipAddr}:3000/api/diary/date/$diaryDate');
          print(url);

          final response = await http.get(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $jwtToken'
            },
          );
          String content = '일기 내용이 없습니다.';

          if (response.statusCode == 200) {
            //JSON 응답 파싱
            final Map<String, dynamic> data = jsonDecode(response.body);

            content = data['content'];

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DiaryScreen(
                  date: selectedDay,
                  //전달받은 content로 일기 보여주기
                  content: content,
                ),
              ),
            );
          } else if (response.statusCode == 400) {
            //유효하지 않은 일기 id 또는 날짜 형식 틀림
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('유효하지 않은 일기 ID 또는 날짜입니다.')),
            );
          } else if (response.statusCode == 404) {
            //404:해당 날짜의 일기 존재하지 않음
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('해당 날짜의 일기가 없습니다.')),
            );
          } else {
            //500: 일기 조회 실패
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('500: 일기 조회에 실패했습니다.')),
            );
          }
        });
        _animationController.reverse(); //원래상태로 되돌아감.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginDataProvider =
        Provider.of<LoginDataProvider>(context, listen: false);
    final jwtToken = loginDataProvider.loginData?.token;
    print("token: $jwtToken"); //jwt token 저장

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            const TitleWidget(
              backgroundColor: Pallete.mainBlue,
              text: '일기 확인하기',
              textColor: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            // 달력
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width * 0.93,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(0, 0),
                      blurRadius: 4,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: TableCalendar(
                    // 월화수목금 간격
                    daysOfWeekHeight: 40,
                    locale: 'ko_KR',
                    firstDay: DateTime.utc(2024, 01, 01), // 확인 가능한 날짜
                    lastDay: DateTime.now(), // 오늘까지 확인 가능
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,

                    // calendar 꾸미기
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                        fontSize: calendarFontSize, // 평일(월~금) 글씨 크기
                        color: Colors.black, // 평일(월~금) 글씨 색상
                      ),
                      weekendStyle: const TextStyle(
                        fontSize: 20, // 주말(토~일) 글씨 크기
                        color: Colors.red, // 주말(토~일) 글씨 색상
                      ),
                    ),

                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                          fontSize: 30.0, fontFamily: "IBMPlexSansKRRegular"),
                      leftChevronIcon: Icon(
                        Icons.arrow_left,
                        size: 40.0,
                      ),
                      rightChevronIcon: Icon(
                        Icons.arrow_right,
                        size: 40.0,
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                      // 선택 날짜 스타일
                      selectedDecoration: const BoxDecoration(
                        color: Pallete.mainBlue, // 선택된 날짜의 배경색
                        shape: BoxShape.circle, // 선택된 날짜를 감싸는 원 모양
                      ),
                      selectedTextStyle: TextStyle(
                        color: Colors.white, // 선택된 날짜의 글씨색
                        fontSize: calendarFontSize *
                            _animation.value, // 선택된 날짜의 글씨 크기
                      ),
                      todayDecoration: const BoxDecoration(
                        color: Color.fromARGB(255, 93, 114, 143), // 오늘 날짜의 배경색
                        shape: BoxShape.circle, // 오늘 날짜를 감싸는 원 모양
                      ),
                      todayTextStyle: TextStyle(
                        color: Colors.white, // 오늘 날짜의 글씨색
                        fontSize: calendarFontSize, // 오늘 날짜의 글씨 크기
                      ),
                      weekendTextStyle: TextStyle(
                        color: Colors.black, // 주말 날짜의 글씨색
                        fontSize: calendarFontSize, // 주말 날짜의 글씨 크기
                      ),
                      defaultTextStyle: TextStyle(
                        color: Colors.black, // 기본 날짜의 글씨색
                        fontSize: calendarFontSize, // 기본 날짜의 글씨 크기
                      ),
                      outsideTextStyle: TextStyle(
                        color: Colors.grey, // 달력 외부 날짜의 글씨색
                        fontSize: calendarFontSize, // 달력 외부 날짜의 글씨 크기
                      ),
                      disabledTextStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.5),
                        fontSize: calendarFontSize, // 오늘 이후 날짜의 글씨 크기
                      ),
                    ),

                    // 해당 날짜가 선택되었는지 여부
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      _handleDaySelected(selectedDay, focusedDay, jwtToken);
                    },

                    onPageChanged: (focusedDay) {
                      // No need to call `setState()` here
                      _focusedDay = focusedDay;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "확인하고자 하는 날짜를",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: Color(0xFF434958),
                fontFamily: "IBMPlexSansKRRegular",
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "달력에서 선택",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF434958),
                    fontFamily: "IBMPlexSansKRBold",
                  ),
                ),
                Text(
                  "해주세요!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: Color(0xFF434958),
                    fontFamily: "IBMPlexSansKRRegular",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
