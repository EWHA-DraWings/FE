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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.sodamGreen,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Pallete.sodamLightBrown,
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
      body: TableCalendar(
        locale: 'ko_KR',
        firstDay: DateTime.utc(2024, 01, 01), //확인가능한 날짜
        lastDay: DateTime.now(), //오늘까지 확인 가능
        focusedDay: DateTime.now(),
        calendarFormat: _calendarFormat,
        //해당 날짜가 선택되었는지 여부
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        //
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay; // update `_focusedDay` here as well
          });
        },

        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}
