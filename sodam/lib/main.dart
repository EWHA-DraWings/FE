import 'package:day_night_time_picker/lib/state/state_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sodam/models/emotion_data.dart';
import 'package:sodam/screens/chat/diary_chat_screen.dart';
import 'package:sodam/screens/login_screen.dart';
import 'package:sodam/screens/signin_start_screen.dart';
import 'package:sodam/screens/main_screen.dart';
import 'package:sodam/screens/report/report_detail_screen.dart';
import 'package:sodam/screens/report/past_report.dart';
import 'package:sodam/screens/report/report_main_screen.dart';
import 'package:sodam/screens/time_select_screen.dart';
import 'package:sodam/screens/self_diagnosis/user_diagnosis_screen.dart';

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
          //UserDiagnosisScreen(),
          //ReportMainScreen(),
          //SigninStartScreen(),
          LoginScreen(),
      //ReportDetailScreen(),
      //DiaryChatScreen(),
      //PastReport(),
      //TimeSelectScreen(),
      //     ReportMainScreen(
      //   name: '홍길동',
      //   daysPast: 3,
      //   emotions: [
      //     EmotionData(emotion: '슬픔', percentage: 50.0),
      //     EmotionData(emotion: '행복', percentage: 40.0),
      //     EmotionData(emotion: '분노', percentage: 10.0),
      //   ],
      // ),
      //ReportDetailScreen(),
      //DiaryChatScreen(),
      //PastReport(),
    );
  }
}
