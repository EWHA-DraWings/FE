import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sodam/screens/Guardian_membership/membership_screen.dart';
import 'package:sodam/screens/self_diagnosis/guardian_diagnosis_screen.dart';
import 'package:sodam/screens/start_screen.dart';

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
      home: MembershipScreen(),
    );
  }
}
