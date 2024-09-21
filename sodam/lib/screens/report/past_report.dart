import 'package:flutter/material.dart';
import 'package:sodam/models/emotion_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/widgets/emo_analysis_widget.dart';
import 'package:sodam/widgets/memory_score_chart.dart';

class PastReport extends StatelessWidget {
  PastReport({super.key});

  final List<EmotionData> emotions = [
    EmotionData(emotion: '당황', percentage: 40.0),
    EmotionData(emotion: '불안', percentage: 30.0),
    EmotionData(emotion: '행복', percentage: 30.0),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
                    EmoAnalysisWidget(
                      user: '김철수',
                      emotions: emotions,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
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
                              text: '슬픔, 행복',
                              style: TextStyle(
                                color: Color(0xFF434857),
                                fontSize: 20,
                                fontFamily: 'IBMPlexSansKRRegular',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                            TextSpan(
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
              child: const Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  top: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
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
                      '무릎이 조금 아프시지만, 잠은 잘 \n주무시는 편이에요. 최근 보조제를\n드시고 계신다고 해요.',
                      style: TextStyle(
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
              child: const Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  top: 20,
                ),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '기억 점수',
                        style: TextStyle(
                          color: Color(0xFF1B1D49),
                          fontSize: 20,
                          fontFamily: 'IBMPlexSansKRRegular',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
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
                        padding: EdgeInsets.only(
                          top: 60,
                          left: 180,
                        ),
                        child: MemoryScoreChart(percentile: 58.2),
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
