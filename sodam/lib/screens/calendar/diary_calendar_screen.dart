import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/diary_screen.dart';
import 'package:table_calendar/table_calendar.dart';

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

  void _handleDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (_selectedDay != selectedDay) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _animationController.forward().then((_) {
        //약간의 딜레이 후 이동
        Future.delayed(const Duration(milliseconds: 100), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const DiaryScreen(), // 나중에 수정 필요 date: selectedDay
            ),
          );
        });
        _animationController.reverse(); //원래상태로 되돌아감.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.sodamIvory,
      appBar: AppBar(
        backgroundColor: Pallete.sodamIvory,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 57, 146, 97),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(0, 0),
                      blurRadius: 4,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "일기 확인하기",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: "IBMPlexSansKRBold"),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // 달력
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
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
                        color: Color.fromARGB(255, 31, 90, 207), // 선택된 날짜의 배경색
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
                      _handleDaySelected(selectedDay, focusedDay);
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
              "보고싶은 날짜를",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: Pallete.sodamBrown,
                fontFamily: "IBMPlexSansKRRegular",
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "달력에서 클릭",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Pallete.sodamBrown,
                    fontFamily: "IBMPlexSansKRBold",
                  ),
                ),
                Text(
                  "해주세요",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: Pallete.sodamBrown,
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
