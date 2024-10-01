import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sodam/screens/chat/diary_chat_screen.dart';
import 'package:sodam/screens/guardian_signin/signin_start_screen.dart';
import 'package:sodam/screens/main_screen.dart';
import 'package:sodam/screens/report/report_detail_screen.dart';
import 'package:sodam/screens/report/past_report.dart';
import 'package:sodam/screens/report/report_main_screen.dart';

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
    return MaterialApp(
      home: //MainScreen(isGuardian: false),
          //MembershipNameScreen(data: GuardianData(role:"guardian"),),
          //UserDiagnosisScreen(),
          ReportMainScreen(),
      //SigninStartScreen(),
      //ReportDetailScreen(),
      //DiaryChatScreen(),
      //PastReport(),
    );
  }
}
