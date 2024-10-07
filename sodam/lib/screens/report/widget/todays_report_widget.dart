import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sodam/models/emotion_data.dart';
import 'package:sodam/models/memory_score_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/report/report_detail_screen.dart';
import 'package:sodam/screens/report/widget/doughnut_chart_widget.dart';
import 'package:sodam/screens/report/widget/memory_chart_widget.dart';

class TodaysReportWidget extends StatelessWidget {
  final String condition;
  final List<EmotionData> emotions; //top3 감정 리스트
  final List<MemoryScoreData> memoryScoreDatas; //지난 11일간 기억 점수 데이터(백분율, cdr)
  /*[
    EmotionData(emotion: '당황', percentage: 40.0),
    EmotionData(emotion: '불안', percentage: 30.0),
    EmotionData(emotion: '행복', percentage: 30.0),
  ];*/

  const TodaysReportWidget({
    super.key,
    required this.condition,
    required this.emotions,
    required this.memoryScoreDatas,
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
    const width = 220.0;
    const height = 270.0;
    const boxColor = Pallete.sodamReportBlue;
    const dateColor = Color.fromARGB(255, 70, 72, 88);
    const titleColor = Color.fromARGB(255, 242, 248, 255);
    const textColor = Colors.black;
    List<Color> colors = [Colors.amber, Colors.red, const Color(0xffAD00FF)];

    //오늘 날짜
    DateTime now = DateTime.now();
    //날짜를 "년/월/일" 형식으로 포맷
    String today = DateFormat('yyyy/MM/dd').format(now);
    String mainEmo = mainEmoToString();
    String notMainEmo = getNotMainEmo();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const SizedBox(width: 5),
          Container(
            width: width,
            height: height,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3), // 그림자의 색상과 투명도
                  spreadRadius: 2, // 그림자의 확산 정도
                  blurRadius: 6, // 그림자의 블러 정도
                  offset: const Offset(2, 2), // 그림자의 위치 (오프셋)
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    today,
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: "IBMPlexSansKRRegular",
                      color: dateColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    "감정 분석 결과",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "IBMPlexSansKRBold",
                        color: titleColor),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    mainEmo,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: "IBMPlexSansKRBold",
                      color: textColor,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "이어서 $notMainEmo이 차지했어요.",
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: "IBMPlexSansKRRegular",
                      color: textColor,
                      height: 1.5,
                    ),
                  ),
                  DoughnutChartWidget(
                    emotions: emotions,
                    doughnutSize: 37,
                    doughnutWidth: 22,
                    offsetX: 60,
                    offsetY: 65,
                    colors: colors,
                    boxWidth: 135,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: width,
            height: height,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3), // 그림자의 색상과 투명도
                  spreadRadius: 2, // 그림자의 확산 정도
                  blurRadius: 6, // 그림자의 블러 정도
                  offset: const Offset(2, 2), // 그림자의 위치 (오프셋)
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    today,
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: "IBMPlexSansKRRegular",
                      color: dateColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    "컨디션",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "IBMPlexSansKRBold",
                        color: titleColor),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    condition,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: "IBMPlexSansKRRegular",
                      color: textColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: width,
            height: height,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3), // 그림자의 색상과 투명도
                  spreadRadius: 2, // 그림자의 확산 정도
                  blurRadius: 6, // 그림자의 블러 정도
                  offset: const Offset(2, 2), // 그림자의 위치 (오프셋)
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    today,
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: "IBMPlexSansKRRegular",
                      color: dateColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    "기억점수",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "IBMPlexSansKRBold",
                        color: titleColor),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: MemoryChartWidget(
                      memoryScoreDatas: memoryScoreDatas,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      width: 200,
                      //height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ReportDetailScreen()),
                          );
                        }, //다음 화면으로 이동
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Pallete.mainWhite,
                          backgroundColor: Pallete.mainBlue, // 버튼 배경 색상
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // 버튼 모서리 둥글기
                          ),
                        ),
                        child: const Text(
                          '자세히 살펴보기',
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'IBMPlexSansKRRegular',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}
