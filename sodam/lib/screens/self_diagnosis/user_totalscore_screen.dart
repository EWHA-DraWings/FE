import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/self_diagnosis/guardian_totalscore_screen.dart';

class UserTotalscoreScreen extends StatelessWidget {
  final int score;

  const UserTotalscoreScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.sodamGreen,
      appBar: AppBar(
        backgroundColor: Pallete.sodamGreen,
        foregroundColor: Pallete.sodamBeige, //글씨 색
        title: const Text(
          "PRMQ 진단 결과",
          style: TextStyle(
            fontSize: 24,
            fontFamily: "Gugi",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              ResultWidget(score: score),
            ],
          ),
        ),
      ),
    );
  }
}
