import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sodam/screens/diary_screen.dart';
import 'package:sodam/screens/guardian_signin/signin_start_screen.dart';
import 'package:sodam/screens/main_screen.dart';
import 'package:sodam/screens/report/past_report.dart';
import 'package:sodam/screens/report/report_main_screen.dart';
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
    return MaterialApp(
      home: //MainScreen(isGuardian: false),
          //MembershipNameScreen(data: GuardianData(role:"guardian"),),
          DiaryScreen(
        date: DateTime(2024, 10, 1, 15, 30),
        content:
            """ 오늘은 아침부터 비가 내렸다. 비 소리를 들으니 마음이 차분해지는 것 같았다. 아침 식사로는 따뜻한 미역국을 끓여 먹었다. 비 오는 날에는 따뜻한 국물이 최고다.
  비가 와서 외출은 못했지만 집에서 할 일이 많았다. 오래된 사진첩을 정리하고, 손자들이 보내준 편지를 읽었다. 손자들이 쓴 편지를 읽으니 눈물이 핑 돌았다. 세월이 참 빠르다는 생각이 들었다.
  점심 후에는 재봉틀로 낡은 옷을 수선했다. 예전에 배운 재봉 솜씨가 아직 녹슬지 않았다. 저녁에는 간단히 계란말이와 나물반찬으로 식사를 하고, 드라마를 보면서 하루를 마무리했다.""",
      ),
      //PastReport(),
    );
  }
}
