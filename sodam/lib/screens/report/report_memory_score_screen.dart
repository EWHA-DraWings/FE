import 'package:flutter/material.dart';
import 'package:sodam/models/memory_score_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/widgets/title_widget.dart';

class ReportMemoryScoreScreen extends StatelessWidget {
  final String today; //오늘 날짜(요일 가져와야됨)

  ReportMemoryScoreScreen({super.key, required this.today});

  final List<MemoryScoreData> memoryScores = [
    MemoryScoreData(date: '0812', score: 79),
    MemoryScoreData(date: '0815', score: 84),
    MemoryScoreData(date: '0818', score: 67),
    MemoryScoreData(date: '0821', score: 73),
    MemoryScoreData(date: '0824', score: 92),
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
          child: const Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleWidget(
                  backgroundColor: Pallete.sodamNewDarkPink,
                  textColor: Colors.white,
                  text: '기억테스트 점수 기록',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
