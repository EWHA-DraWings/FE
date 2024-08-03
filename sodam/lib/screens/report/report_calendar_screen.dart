import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:table_calendar/table_calendar.dart';

class ReportCalendarScreen extends StatefulWidget {
  const ReportCalendarScreen({super.key});

  @override
  State<ReportCalendarScreen> createState() => _ReportCalendarScreenState();
}

class _ReportCalendarScreenState extends State<ReportCalendarScreen> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now(); //화면에 표시된 날짜
  DateTime? _selectedDay; //사용자 선택 날짜
  final double calendarFontSize = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.sodamGreen,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Pallete.sodamGreen,
        foregroundColor: Colors.white, //글씨 색
        title: const Text(
          "리포트",
          style: TextStyle(
            color: Pallete.sodamBeige,
            fontSize: 40,
            fontWeight: FontWeight.w800,
            fontFamily: "PoorStory",
          ),
        ),
      ),
      body: Column(
        children: [
          //달력
          Container(
            //달력 배경 색 추가 목적
            //달력 높이 바뀌어서 고정용
            height: 450,
            width: 350,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: TableCalendar(
              //월화수목금 간격
              daysOfWeekHeight: 30,
              locale: 'ko_KR',
              firstDay: DateTime.utc(2024, 01, 01), //확인가능한 날짜
              lastDay: DateTime.now(), //오늘까지 확인 가능
              focusedDay: DateTime.now(),
              calendarFormat: _calendarFormat,

              //calendar 꾸미기
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
                    fontSize: 30.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: "IBMPlexSansKRRegular"),
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
                selectedTextStyle: TextStyle(
                  color: Colors.white, // 선택된 날짜의 글씨색
                  fontSize: calendarFontSize, // 선택된 날짜의 글씨 크기
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

              //해당 날짜가 선택되었는지 여부
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              //
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay =
                      selectedDay; // update `_focusedDay` here as well
                });
              },

              onPageChanged: (focusedDay) {
                // No need to call `setState()` here
                _focusedDay = focusedDay;
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "리포트를 확인하고자 하는 날짜를 달력에서 선택해주세요.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: Pallete.sodamBrown,
              fontFamily: "PoorStory",
            ),
          ),
        ],
      ),
    );
  }
}
