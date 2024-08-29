import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sodam/models/emotion_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/widgets/round_next_button.dart';

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
                const RoundNextButton(
                  btnText: '기억점수 조회하기',
                  btnColor: Pallete.sodamYellow,
                  emoji: '🔎',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShadowWhiteContainer extends StatelessWidget {
  final double height;
  final String title;
  final Widget child;
  final bool isRight; //text가 오른쪽에 놓이면 true

  const ShadowWhiteContainer({
    super.key,
    required this.title,
    required this.child,
    required this.height,
    required this.isRight,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'IBMPlexSansKRBold',
                fontSize: 25,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 10,
            ),
            isRight
                ? Align(
                    alignment:
                        Alignment.centerRight, // Align the child to the right
                    child: child,
                  )
                : child,
          ],
        ),
      ),
    );
  }
}

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
    String mainEmo = emotions[0].emotion;
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
      Colors.lightBlue,
      Colors.pink,
      Colors.green,
    ];
    //emotions 최대 3개, emotions[0]이 mainEmo 가정
    for (int i = 0; i < emotions.length; i++) {
      sections.add(
        PieChartSectionData(
          value: emotions[i].percentage,
          title: '${emotions[i].emotion}\n${emotions[i].percentage}',
          color: colors[i],
          radius: emotions[i].isMainEmo ? 80 : 70,
          titleStyle: const TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.w400,
            fontFamily: "IBMPlexSansKRRegular",
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
          children: [
            const SizedBox(height: 10),
            const Text(
              '오늘의\n대표 감정',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'IBM Plex Sans KR',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              mainEmoToString(),
              style: const TextStyle(
                fontSize: 40,
                fontFamily: "IBMPlexSansKRRegular",
                fontWeight: FontWeight.w600,
                color: Pallete.sodamOrange,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
        SizedBox(
          width: 200,
          height: 200,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 20,
              sections: buildPieChartSections(),
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
