import 'package:flutter/material.dart';
import 'package:sodam/models/emotion_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/report/widget/doughnut_chart_widget.dart';
import 'package:sodam/widgets/memory_score_chart.dart';

class PastReport extends StatelessWidget {
  final String name;
  final String condition;
  final double memoryScore;
  final List<EmotionData> emotions; //top3 감정 리스트

  const PastReport(
      {super.key,
      required this.name,
      required this.condition,
      required this.memoryScore,
      required this.emotions});

//main emotion이 2개 이상일 경우 체크
  String mainEmoToString() {
    String mainEmo = '${emotions[0].emotion} ${emotions[0].percentage}%';
    emotions[0].isMainEmo = true;
    for (int i = 0; i < emotions.length - 1; i++) {
      if (emotions[i].percentage == emotions[i + 1].percentage) {
        emotions[i + 1].isMainEmo = true;
        mainEmo += '\n${emotions[i + 1].emotion}';
      } else {
        break;
      }
    }
    return mainEmo;
  }

  //main emotion 아닌 애들 처리
  String getNotMainEmo() {
    String notMainEmo = '';
    for (int i = 1; i < emotions.length; i++) {
      if (!emotions[i].isMainEmo) {
        notMainEmo += emotions[i].emotion;
        if (i != emotions.length - 1) {
          notMainEmo += ' ';
        }
      }
    }
    return notMainEmo;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    String mainEmo = mainEmoToString();
    String notMainEmo = getNotMainEmo();
    List<Color> colors = [
      Colors.blue,
      Colors.lightGreen,
      Colors.pink,
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Pallete.sodamReportPurple,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            Container(
              width: screenWidth * 0.9,
              height: 290,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 15,
                      ),
                      child: Text(
                        '감정 분석 결과',
                        style: TextStyle(
                          color: Color(0xFF1B1D49),
                          fontSize: 20,
                          fontFamily: 'IBMPlexSansKRRegular',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          child: DoughnutChartWidget(
                            emotions: emotions,
                            doughnutSize: 60,
                            doughnutWidth: 40,
                            offsetX: 100,
                            offsetY: 90,
                            colors: colors,
                            boxWidth: 220,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 70),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: '이어서 \n',
                              style: TextStyle(
                                color: Color(0xFF434857),
                                fontSize: 20,
                                fontFamily: 'IBMPlexSansKRRegular',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            TextSpan(
                              text: notMainEmo,
                              style: const TextStyle(
                                color: Color(0xFF434857),
                                fontSize: 20,
                                fontFamily: 'IBMPlexSansKRRegular',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                            const TextSpan(
                              text: '이 차지했어요.',
                              style: TextStyle(
                                color: Color(0xFF434857),
                                fontSize: 20,
                                fontFamily: 'IBMPlexSansKRRegular',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: screenWidth * 0.9,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        '컨디션',
                        style: TextStyle(
                          color: Color(0xFF1B1D49),
                          fontSize: 20,
                          fontFamily: 'IBMPlexSansKRRegular',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      condition,
                      style: const TextStyle(
                        color: Color(0xFF434958),
                        fontSize: 20,
                        fontFamily: 'IBMPlexSansKRRegular',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: screenWidth * 0.9,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 20,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '기억 점수',
                        style: TextStyle(
                          color: Color(0xFF1B1D49),
                          fontSize: 20,
                          fontFamily: 'IBMPlexSansKRRegular',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        '최근 기억 테스트 결과',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'IBMPlexSansKRRegular',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 60,
                          left: 160,
                        ),
                        child: MemoryScoreChart(percentile: memoryScore),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
