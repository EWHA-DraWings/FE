import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

class MemoryScoreChart extends StatelessWidget {
  final double? percentile;
  const MemoryScoreChart({super.key, required this.percentile});

  @override
  Widget build(BuildContext context) {
    double score = percentile! * 100;
    return percentile != null
        ? SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.2,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    centerSpaceRadius: 60,
                    sectionsSpace: 10,
                    startDegreeOffset: 90,
                    sections: [
                      PieChartSectionData(
                        radius: 30,
                        value: score,
                        showTitle: false,
                        color: Colors.cyan,
                      ),
                      PieChartSectionData(
                        radius: 20,
                        value: 100 - score,
                        showTitle: false,
                        color: Pallete.mainGray,
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: percentile != 0 ? '$score' : '기록 없음',
                        style: const TextStyle(
                          color: Colors.cyan,
                          fontSize: 30,
                          fontFamily: 'IBMPlexSansKRRegular',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: '\n/100',
                        style: TextStyle(
                          color: Color(0xFF434857),
                          fontSize: 22,
                          fontFamily: 'IBMPlexSansKRRegular',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : const Text('해당 날짜의 기억 테스트 기록이 없습니다.');
  }
}
