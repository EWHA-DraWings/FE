import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/main_screen.dart';
import 'package:sodam/widgets/title_widget.dart';

import '../../widgets/round_next_button.dart';
import '../../widgets/self_diagnosis_result_widget.dart';

class GuardianTotalscoreScreen extends StatelessWidget {
  final int score;
  final String name;
  const GuardianTotalscoreScreen(
      {super.key, required this.score, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, //글씨 색
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const TitleWidget(
                backgroundColor: Pallete.mainBlue,
                textColor: Colors.white,
                text: '보호자 자가진단 결과',
              ),
              const SizedBox(height: 10),
              SelfDiagnosisResultWidget(
                score: score,
                //사용자의 이름이어야함
                name: name,
                isElderly: false,
              ),
              const SizedBox(
                height: 20,
              ),
              const RoundNextButton(
                btnText: '결과 공유하기',
                btnColor: Pallete.mainGray,
                emoji: '🔗',
                screen: MainScreen(
                  isGuardian: true,
                ), //임시
              ),
              const SizedBox(
                height: 15,
              ),
              const RoundNextButton(
                btnText: '가까운 병원 찾아보기',
                btnColor: Pallete.mainGray,
                emoji: '🏥',
                screen: MainScreen(
                  isGuardian: true,
                ), //임시
              ),
              const SizedBox(
                height: 15,
              ),
              const RoundNextButton(
                btnText: '자가진단 기록 살펴보기',
                btnColor: Pallete.mainGray,
                emoji: '📊',
                screen: MainScreen(
                  isGuardian: true,
                ), //임시
              ),
            ],
          ),
        ),
      ),
    );
  }
}
