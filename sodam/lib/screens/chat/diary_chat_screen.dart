import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

class DiaryChatScreen extends StatefulWidget {
  const DiaryChatScreen({super.key});

  @override
  State<DiaryChatScreen> createState() => _DiaryChatScreenState();
}

class _DiaryChatScreenState extends State<DiaryChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.sodamGreen,
      appBar: AppBar(
        backgroundColor: Pallete.sodamGreen,
        foregroundColor: Pallete.sodamDarkPink, //글씨 색
        title: const Text(
          "소담이랑 대화하기",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            fontFamily: "Gugi",
          ),
        ),
      ),
      body: Column(
        
      )
    );
  }
}