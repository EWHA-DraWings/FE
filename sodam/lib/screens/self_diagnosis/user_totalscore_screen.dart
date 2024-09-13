import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/main_screen.dart';
import 'package:sodam/widgets/round_next_button.dart';

import '../../widgets/self_diagnosis_result_widget.dart';
import '../../widgets/title_widget.dart';

class UserTotalscoreScreen extends StatelessWidget {
  final int score;

  const UserTotalscoreScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.sodamIvory,
      appBar: AppBar(
        backgroundColor: Pallete.sodamIvory,
        foregroundColor: Colors.black, //글씨 색
        title: const Text(
          "PRMQ 진단 결과",
          style: TextStyle(
            fontSize: 25,
            fontFamily: "IBMPlexSansKRRegular",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const TitleWidget(
                backgroundColor: Pallete.sodamYellow,
                textColor: Pallete.sodamBrown,
                text: '자가진단 결과',
              ),
              const SizedBox(
                height: 10,
              ),
              SelfDiagnosisResultWidget(
                score: score,
                name: '홍길동',
              ),
              const SizedBox(
                height: 20,
              ),
              const RoundNextButton(
                btnText: '결과 공유하기',
                btnColor: Pallete.sodamOrange,
                emoji: '🔗',
                screen: MainScreen(
                  isGuardian: false,
                ), //임시
              ),
              const SizedBox(
                height: 10,
              ),
              const RoundNextButton(
                btnText: '가까운 병원 찾아보기',
                btnColor: Pallete.sodamNewGreen,
                emoji: '🏥',
                screen: MainScreen(
                  isGuardian: false,
                ), //임시
              ),
              const SizedBox(
                height: 10,
              ),
              const RoundNextButton(
                btnText: '자가진단 기록 살펴보기',
                btnColor: Pallete.sodamYellow,
                emoji: '📊',
                screen: MainScreen(
                  isGuardian: false,
                ), //임시
              ),
            ],
          ),
        ),
      ),
    );
  }
}
