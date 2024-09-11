import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sodam/models/guardian_data.dart';
import 'package:sodam/screens/Guardian_membership/membership_name_screen.dart';
import 'package:sodam/screens/Guardian_membership/membership_screen.dart';
import 'package:sodam/screens/calendar/diary_calendar_screen.dart';
import 'package:sodam/screens/calendar/report_calendar_screen.dart';
import 'package:sodam/screens/login_screen.dart';
import 'package:sodam/screens/main_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialization(null);

  await initializeDateFormatting();
  runApp(const MainApp());
}

Future initialization(BuildContext? context) async {
  //splash 화면 3초간
  await Future.delayed(const Duration(seconds: 3));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: //MainScreen(isGuardian: false),
          //MembershipNameScreen(data: GuardianData(role:"guardian"),),
          ReportCalendarScreen(),
    );
  }
}
