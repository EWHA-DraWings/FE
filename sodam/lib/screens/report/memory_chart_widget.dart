import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

class AppColors {
  static const Color contentColorBlue = Color.fromARGB(255, 90, 7, 255);
  static const Color contentColorCyan = Color.fromARGB(255, 63, 143, 255);
}

class MemoryChartWidget extends StatefulWidget {
  const MemoryChartWidget({super.key});

  @override
  State<MemoryChartWidget> createState() => _MemoryChartWidgetState();
}

class _MemoryChartWidgetState extends State<MemoryChartWidget> {
  List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];
  int selectedIndex = 10; // 터치된 인덱스 (처음에 가장 최근의 점수를 가리키도록)
  Offset? touchedPosition; //터치한 위치 감지

  void processData(List<Map<String, dynamic>> data) {
    const maxY = 6.0; // The maximum value on the y-axis
    const maxScore = 100.0; // Maximum score is 100

    // y축(0-6)에 맞게 백분율을 좌표값으로 점수 변환하여 새로운 map 만들기
    for (int i = 0; i < data.length; i++) {
      final score = (data[i]['score'] as num).toDouble();
      final normalizedScore = double.parse(((score / maxScore) * maxY)
          .toStringAsFixed(1)); // Map score to 0-6 range

      // Create FlSpot and add to the data
      data[i]['spot'] = FlSpot(i.toDouble(), normalizedScore);
    }
  }

  final List<Map<String, dynamic>> data = [
    {'date': '2023-08-25', 'score': 100, 'cdr': 1},
    {'date': '2023-08-28', 'score': 98.1, 'cdr': 1},
    {'date': '2023-08-31', 'score': 70, 'cdr': 1},
    {'date': '2023-09-03', 'score': 66.6, 'cdr': 1},
    {'date': '2023-09-06', 'score': 100, 'cdr': 1},
    {'date': '2023-09-09', 'score': 83.3, 'cdr': 1},
    {'date': '2023-09-12', 'score': 38, 'cdr': 1},
    {'date': '2023-09-15', 'score': 22, 'cdr': 1},
    {'date': '2023-09-18', 'score': 77.8, 'cdr': 1},
    {'date': '2023-09-21', 'score': 90, 'cdr': 1},
    {'date': '2023-09-24', 'score': 88, 'cdr': 1},
  ];

  @override
  Widget build(BuildContext context) {
    processData(data);
    final selectedSpot = data[selectedIndex];

    // Print the transformed data with the new FlSpot
    for (var entry in data) {
      print(
          'Date: ${entry['date']}, Score: ${entry['score']}, Spot: ${entry['spot']}');
    }

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
            top: -selectedSpot['score'].toDouble() + 40, //세로 위치조정

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
    final selectedSpot = data[selectedIndex];
    final date = selectedSpot['date'];
    final value = selectedSpot['score'];
    final cdr = selectedSpot['cdr'];

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
            '$date',
            style: const TextStyle(
              color: Color.fromARGB(255, 106, 106, 106),
              fontSize: 11,
              fontFamily: "IBMPlexSansKRRegular",
            ),
          ),
          Text(
            '$value (CDR:$cdr)',
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
          // 터치가 끝나면 툴팁 유지
          if (event is FlPanEndEvent || event is FlTapUpEvent) {
            setState(() {
              // 터치가 끝나면 툴팁 유지
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
          spots: data.map((e) => e['spot'] as FlSpot).toList(),
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
