import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sodam/models/login_data.dart';
import 'package:sodam/models/memory_score_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/widgets/title_widget.dart';
import 'package:http/http.dart' as http; //http 가져오기

class MemoryscoreDetailScreen extends StatelessWidget {
  final List<MemoryScoreData> memoryScoreDatas;

  const MemoryscoreDetailScreen({super.key, required this.memoryScoreDatas});

  @override
  Widget build(BuildContext context) {
    //data 불러오기

    return Scaffold(
      backgroundColor: Pallete.mainWhite,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          const TitleWidget(
            backgroundColor: Pallete.mainBlue,
            text: '기억점수 살펴보기',
            textColor: Colors.white,
          ),
          const SizedBox(
            height: 10,
          ),
          // ...memoryScoreDatas.map((data) {
          //   return MemoryScoreCard(data: data);
          // }),
          Expanded(
            child: ListView.builder(
              itemCount: memoryScoreDatas.length,
              itemBuilder: (context, index) {
                final data = memoryScoreDatas[index];
                return MemoryScoreCard(data: data);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MemoryScoreCard extends StatelessWidget {
  final MemoryScoreData data;

  const MemoryScoreCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    double correctPercentile = data.correctRatio * 100;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5, // 그림자의 부드러움 정도
              spreadRadius: 3, // 그림자가 퍼지는 정도
              offset: Offset(0, 0), // 그림자를 특정 방향으로 치우치지 않게 함
            )
          ],
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                data.date,
                style: const TextStyle(
                  fontFamily: "IBMPlexSansKRRegular",
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
              child: Row(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "CDR  ",
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: "IBMPlexSansKRRegular",
                            color: Pallete.mainBlack,
                          ),
                        ),
                        TextSpan(
                          text: "${data.cdrScore}",
                          style: const TextStyle(
                            fontSize: 45,
                            fontFamily: "IBMPlexSansKRBold",
                            color: Pallete.mainBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$correctPercentile%',
                        style: const TextStyle(
                          fontSize: 35,
                          fontFamily: "IBMPlexSansKRRegular",
                          color: Pallete.mainBlack,
                        ),
                      ),
                      Text(
                        '정답률 (${data.correctCount}문제/${data.questionCount}문제)',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
