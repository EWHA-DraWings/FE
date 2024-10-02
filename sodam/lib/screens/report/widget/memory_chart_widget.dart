import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sodam/models/memory_score_data.dart';
import 'package:sodam/pallete.dart';

class AppColors {
  static const Color contentColorBlue = Color.fromARGB(255, 90, 7, 255);
  static const Color contentColorCyan = Color.fromARGB(255, 63, 143, 255);
}

class MemoryChartWidget extends StatefulWidget {
  final List<MemoryScoreData> memoryScoreDatas;
  const MemoryChartWidget({super.key, required this.memoryScoreDatas});

  @override
  State<MemoryChartWidget> createState() => _MemoryChartWidgetState();
}

class _MemoryChartWidgetState extends State<MemoryChartWidget> {
  List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];
  int selectedIndex = 10; // 터치된 인덱스 (처음에 가장 최근의 점수를 가리키도록)
  Offset? touchedPosition; // 터치한 위치 감지

  @override
  Widget build(BuildContext context) {
    final selectedSpot = widget.memoryScoreDatas[selectedIndex];

    return Stack(
      clipBehavior: Clip.none, // 클리핑 비활성화
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16 / 9, // 그래프 비율: 가로/세로
          child: LineChart(mainData()),
        ),
        if (touchedPosition != null && selectedIndex != -1)
          Positioned(
            left: touchedPosition!.dx - 10, // 터치된 위치에 컨테이너를 배치
            top: -selectedSpot.score + 36, // 세로 위치조정
            child: buildCustomTooltip(),
          ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontFamily: "IBMPlexSansKRRegular",
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '25';
        break;
      case 2:
        text = '31';
        break;
      case 4:
        text = '6';
        break;
      case 6:
        text = '12';
        break;
      case 8:
        text = '18';
        break;
      case 10:
        text = '24';
        break;
      default:
        text = '';
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 3:
        text = '50';
        break;
      case 6:
        text = '100';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style, textAlign: TextAlign.right),
    );
  }

  Widget buildCustomTooltip() {
    final selectedSpot = widget.memoryScoreDatas[selectedIndex];
    final date = selectedSpot.date;
    final value = selectedSpot.score;
    final cdr = selectedSpot.cdr;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            date,
            style: const TextStyle(
              color: Color.fromARGB(255, 106, 106, 106),
              fontSize: 11,
              fontFamily: "IBMPlexSansKRRegular",
            ),
          ),
          Text(
            '$value (CDR: $cdr)',
            style: const TextStyle(
              color: Pallete.mainBlue,
              fontSize: 14,
              fontFamily: "IBMPlexSansKRBold",
            ),
          ),
        ],
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        handleBuiltInTouches: false,
        touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
          if (response != null && response.lineBarSpots != null) {
            setState(() {
              final spot = response.lineBarSpots!.first;
              selectedIndex = spot.x.toInt(); // 터치한 인덱스를 저장
              touchedPosition = event.localPosition; // 터치된 위치 저장
            });
          }
          if (event is FlPanEndEvent || event is FlTapUpEvent) {
            setState(() {
              touchedPosition = touchedPosition;
            });
          }
        },
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.white38,
            strokeWidth: 2,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.white38,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 25,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 30,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
      ),
      minX: 0,
      maxX: 10,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: widget.memoryScoreDatas
              .map((e) => FlSpot(widget.memoryScoreDatas.indexOf(e).toDouble(),
                  e.score / 100 * 6))
              .toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              if (index == selectedIndex) {
                return FlDotCirclePainter(
                  radius: 6,
                  color: const Color.fromARGB(
                      255, 57, 54, 244), // Selected dot color
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              } else {
                return FlDotCirclePainter(
                  radius: 3,
                  color: Colors.white, // Default dot color
                  strokeWidth: 1,
                  strokeColor: Colors.blue,
                );
              }
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.5))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
