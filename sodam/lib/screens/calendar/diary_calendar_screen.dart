import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/diary_screen.dart';
import 'package:sodam/widgets/title_widget.dart';
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
              builder: (context) => DiaryScreen(
                date: selectedDay,
                content:
                    """ 오늘은 아침부터 비가 내렸다. 비 소리를 들으니 마음이 차분해지는 것 같았다. 아침 식사로는 따뜻한 미역국을 끓여 먹었다. 비 오는 날에는 따뜻한 국물이 최고다.
  비가 와서 외출은 못했지만 집에서 할 일이 많았다. 오래된 사진첩을 정리하고, 손자들이 보내준 편지를 읽었다. 손자들이 쓴 편지를 읽으니 눈물이 핑 돌았다. 세월이 참 빠르다는 생각이 들었다.
  점심 후에는 재봉틀로 낡은 옷을 수선했다. 예전에 배운 재봉 솜씨가 아직 녹슬지 않았다. 저녁에는 간단히 계란말이와 나물반찬으로 식사를 하고, 드라마를 보면서 하루를 마무리했다.""",
              ),
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
