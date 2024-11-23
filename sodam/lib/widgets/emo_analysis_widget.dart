import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sodam/models/emotion_data.dart';

class EmoAnalysisWidget extends StatelessWidget {
  final String user;
  final List<EmotionData> emotions; //top3 감정 리스트

  const EmoAnalysisWidget({
    super.key,
    required this.user,
    required this.emotions,
  });

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

  //emotions가 3개보다 작을 경우를 고려하여 처리하는 함수
  List<PieChartSectionData> buildPieChartSections() {
    List<PieChartSectionData> sections = [];
    List<Color> colors = [
      const Color(0xffDADC5F),
      Colors.pink,
      Colors.green,
    ];
    //emotions 최대 3개, emotions[0]이 mainEmo 가정
    for (int i = 0; i < emotions.length; i++) {
      sections.add(
        PieChartSectionData(
          titlePositionPercentageOffset: 0.5,
          value: emotions[i].percentage,
          title: '${emotions[i].emotion}\n${emotions[i].percentage}',
          color: colors[i],
          radius: emotions[i].isMainEmo ? 35 : 30,
          titleStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: "IBMPlexSansKRRegular",
            backgroundColor: Colors.black,
          ),
        ),
      );
    }

    return sections;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              '주요 감정',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'IBMPlexSansKRRegular',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              mainEmoToString(),
              style: const TextStyle(
                fontSize: 30,
                fontFamily: "IBMPlexSansKRRegular",
                fontWeight: FontWeight.w600,
                color: Color(0xFF344BFD),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 20,
            top: 10,
          ),
          child: SizedBox(
            width: 120,
            height: 120,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 35,
                sectionsSpace: 0,
                sections: buildPieChartSections(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
