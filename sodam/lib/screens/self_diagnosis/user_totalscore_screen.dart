import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sodam/models/login_data.dart';
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
    final loginDataProvider =
        Provider.of<LoginDataProvider>(context, listen: false);
    final name = loginDataProvider.loginData!.name;
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
                text: '자가진단 결과',
              ),
              const SizedBox(
                height: 10,
              ),
              SelfDiagnosisResultWidget(
                score: score,
                name: name,
                isElderly: true,
              ),
              const SizedBox(
                height: 20,
              ),
              const RoundNextButton(
                btnText: '자가진단 기록 살펴보기',
                btnColor: Pallete.mainGray,
                emoji: '📊',
                screen: MainScreen(
                  isGuardian: false,
                ), //임시
              ),
              const SizedBox(
                height: 15,
              ),
              const RoundNextButton(
                btnText: '홈 화면으로 돌아가기',
                btnColor: Pallete.mainGray,
                emoji: '🏠',
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
