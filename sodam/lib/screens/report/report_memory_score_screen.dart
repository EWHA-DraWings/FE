import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sodam/models/memory_score_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/main_screen.dart';
import 'package:sodam/widgets/round_next_button.dart';
import 'package:sodam/widgets/title_widget.dart';

class ReportMemoryScoreScreen extends StatelessWidget {
  final String today; //오늘 날짜(요일 가져와야됨)
  final String user; //이름

  ReportMemoryScoreScreen({super.key, required this.today, required this.user});

  final List<MemoryScoreData> memoryScores = [
    MemoryScoreData(date: '8/12', score: 79),
    MemoryScoreData(date: '8/15', score: 84),
    MemoryScoreData(date: '8/18', score: 67),
    MemoryScoreData(date: '8/21', score: 73),
    MemoryScoreData(date: '8/24', score: 92),
  ];

  //x축 레이블 반환하는 함수
  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontFamily: 'IBMPlexSansKRRegular',
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = memoryScores[0].date;
        break;
      case 1:
        text = memoryScores[1].date;
        break;
      case 2:
        text = memoryScores[2].date;
        break;
      case 3:
        text = memoryScores[3].date;
        break;
      case 4:
        text = memoryScores[4].date;
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  List<BarChartGroupData> buildBarChartGroupDatas() {
    List<BarChartGroupData> barGroups = [];

    for (int i = 0; i < memoryScores.length; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: memoryScores[i].score,
              width: 20,
              borderRadius: BorderRadius.circular(5),
              color: i == memoryScores.length - 1
                  ? Pallete.sodamOrange
                  : Pallete.sodamNewGreen,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
      );
    }
    return barGroups;
  }

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
                const TitleWidget(
                  backgroundColor: Pallete.sodamNewDarkPink,
                  textColor: Colors.white,
                  text: '기억테스트 점수 기록',
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    '$user님의 최근 5번의\n기억테스트 점수 기록이에요!',
                    style: const TextStyle(
                      fontFamily: 'IBMPlexSansKR',
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.4,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: BarChart(
                    BarChartData(
                      maxY: 100,
                      minY: 10,
                      //바 선택했을 때
                      barTouchData: BarTouchData(
                        enabled: false,
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipColor: (group) => Colors.transparent,
                          tooltipMargin: -5,
                          tooltipPadding: EdgeInsets.zero,
                          getTooltipItem: (
                            BarChartGroupData group,
                            int groupIndex,
                            BarChartRodData rod,
                            int rodIndex,
                          ) {
                            return BarTooltipItem(
                              rod.toY.round().toString(),
                              const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'IBMPlexSansKRRegular',
                              ),
                            );
                          },
                        ),
                      ),
                      //레이블
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: getTitles,
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: const Border(
                          top: BorderSide.none,
                        ),
                      ),
                      gridData: const FlGridData(
                        show: false,
                      ),
                      //바 데이터
                      barGroups: buildBarChartGroupDatas(),
                    ),
                  ),
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
                  height: 20,
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
                  height: 20,
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
      ),
    );
  }
}
