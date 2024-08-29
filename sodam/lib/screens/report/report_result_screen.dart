import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sodam/models/emotion_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/report/report_memory_score_screen.dart';
import 'package:sodam/widgets/round_next_button.dart';

import '../../widgets/emo_analysis_widget.dart';
import '../../widgets/shadow_white_container.dart';

class ReportResultScreen extends StatelessWidget {
  final String reportDate; //리포트 날짜(요일 가져와야됨)

  ReportResultScreen({super.key, required this.reportDate});

  final List<EmotionData> emotions = [
    EmotionData(emotion: '당황', percentage: 40.0),
    EmotionData(emotion: '불안', percentage: 30.0),
    EmotionData(emotion: '행복', percentage: 30.0),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Pallete.sodamIvory,
      appBar: AppBar(
        backgroundColor: Pallete.sodamIvory,
        foregroundColor: Colors.black,
        scrolledUnderElevation: 0, //스크롤 시 appbar 색상이 바뀌는 점 해결.
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reportDate,
                  style: const TextStyle(
                    fontFamily: "IBMPlexSansKRRegular",
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const ShadowWhiteContainer(
                  title: '보호자에게 전하고 싶은 말',
                  height: 150,
                  isRight: false,
                  child: Text(
                    '나는 잘 지내니 밥 잘 챙겨먹고 \n다녀라.',
                    style: TextStyle(
                      fontFamily: 'IBMPlexSansKRRegular',
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  //이미지 클립하면서 컨디션 상자 그림자 사라지는 이슈 있음
                  children: [
                    const ShadowWhiteContainer(
                      title: '컨디션',
                      height: 160,
                      isRight: true,
                      child: Text(
                        '저녁을 드시고 소화가 안 되어\n소화제를 드셨대요.',
                        style: TextStyle(
                          fontFamily: 'IBMPlexSansKRRegular',
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Positioned(
                      top: 50,
                      right: 265,
                      child: SizedBox(
                        width: 110,
                        child: Opacity(
                          opacity: 0.5,
                          child: Image.asset("lib/assets/images/health.png"),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ShadowWhiteContainer(
                  title: '감정분석 결과',
                  height: 300,
                  isRight: false,
                  child: EmoAnalysisWidget(
                    user: '홍길동',
                    emotions: emotions,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                RoundNextButton(
                  btnText: '기억점수 조회하기',
                  btnColor: Pallete.sodamYellow,
                  emoji: '🔎',
                  screen: ReportMemoryScoreScreen(
                    today: '0830',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
