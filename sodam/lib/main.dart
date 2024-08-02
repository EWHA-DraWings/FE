import 'package:flutter/material.dart';
import 'package:sodam/screens/diary_screen.dart';
import 'package:sodam/screens/main_screen.dart';
import 'package:sodam/screens/register_type_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DiaryScreen(),
    );
  }
}
