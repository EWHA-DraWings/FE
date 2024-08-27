import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sodam/models/emotion_data.dart';
import 'package:sodam/pallete.dart';

class ReportResultScreen extends StatelessWidget {
  ReportResultScreen({super.key});

  final List<EmotionData> emotions = [
    EmotionData(emotion: '당황', percentage: 40.0),
    EmotionData(emotion: '불안', percentage: 30.0),
    EmotionData(emotion: '행복', percentage: 20.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.sodamGreen,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Pallete.sodamGreen,
        foregroundColor: Colors.white, //글씨 색
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0), // 선의 두께
          child: Container(
            color: Colors.white,
            height: 2.0, // 선의 두께
          ),
        ),
        title: const Text(
          "리포트",
          style: TextStyle(
            color: Pallete.sodamBeige,
            fontSize: 40,
            fontWeight: FontWeight.w800,
            fontFamily: "PoorStory",
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Pallete.sodamBeige,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '8월 14일',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      fontFamily: "IBMPlexSansKR",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.black, // 윤곽선 색상
                      width: 2, // 윤곽선 두께
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Center(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Text(
                          '하고 싶은 말',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w500,
                            fontFamily: "PoorStory",
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '나는 잘 지내니\n밥 잘 챙겨먹고 다녀라.\n 연락 좀 자주해라.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: "PoorStory",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  //배치 맘에 안 들어서 수정 필요
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ResultTypeButton(
                      resultType: '컨디션',
                      isSelected: true,
                    ),
                    ResultTypeButton(
                      resultType: '감정 분석',
                      isSelected: false,
                    ),
                  ],
                ),
                Container(
                  height: 400,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Pallete.sodamPink, // 윤곽선 색상
                      width: 5, // 윤곽선 두께
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Center(
                    child: /*ConditionWidget(
                      user: '홍길동',
                      conditionStatus: '저녁을 드시고 소화가 안 되어\n소화제를 드셨대요.',
                    ),*/
                        EmoAnalysisWidget(
                      user: '홍길동',
                      mainEmo: '당황',
                      emotions: emotions,
                    ),
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

class EmoAnalysisWidget extends StatelessWidget {
  final String user;
  final String mainEmo; //대표 감정
  final List<EmotionData> emotions; //top3 감정 리스트

  const EmoAnalysisWidget({
    super.key,
    required this.user,
    required this.mainEmo,
    required this.emotions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          '$user님의 감정',
          style: const TextStyle(
            fontSize: 30,
            fontFamily: "DoHyeon",
            decoration: TextDecoration.underline, // 밑줄 추가
            decorationColor: Colors.black, // 밑줄 색상
            decorationThickness: 2, // 밑줄 두께
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '오늘의 대표 감정: $mainEmo',
          style: const TextStyle(
            fontSize: 26,
            fontFamily: "PoorStory",
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          '감정 분석 Top3',
          style: TextStyle(
            fontSize: 26,
            fontFamily: "PoorStory",
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 200,
          height: 200,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 20,
              sections: [
                PieChartSectionData(
                  value: emotions[0].percentage,
                  title: emotions[0].emotion,
                  color: Colors.lightBlue,
                  radius: 70,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    fontFamily: "PoorStory",
                  ),
                ),
                PieChartSectionData(
                  value: emotions[1].percentage,
                  title: emotions[1].emotion,
                  color: Colors.pink,
                  radius: 70,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    fontFamily: "PoorStory",
                  ),
                ),
                PieChartSectionData(
                  value: emotions[2].percentage,
                  title: emotions[2].emotion,
                  color: Colors.green,
                  radius: 70,
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    fontFamily: "PoorStory",
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ConditionWidget extends StatelessWidget {
  final String user;
  final String conditionStatus;

  const ConditionWidget({
    super.key,
    required this.user,
    required this.conditionStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          '$user님의 컨디션',
          style: const TextStyle(
            fontSize: 30,
            fontFamily: "DoHyeon",
            decoration: TextDecoration.underline, // 밑줄 추가
            decorationColor: Colors.black, // 밑줄 색상
            decorationThickness: 2, // 밑줄 두께
          ),
        ),
        const SizedBox(height: 20),
        Text(
          conditionStatus,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontFamily: "PoorStory",
          ),
        ),
      ],
    );
  }
}

class ResultTypeButton extends StatelessWidget {
  final String resultType;
  final bool isSelected;

  const ResultTypeButton({
    super.key,
    required this.resultType,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 100,
      decoration: BoxDecoration(
        color: isSelected ? Pallete.sodamPink : Pallete.sodamBeige,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        resultType,
        style: TextStyle(
          fontSize: 24,
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w400,
          fontFamily: "PoorStory",
        ),
      ),
    );
  }
}
