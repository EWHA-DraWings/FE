import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/widgets/title_widget.dart';

class MemoryscoreDetailScreen extends StatelessWidget {
  final List<Map<String, dynamic>> scoreData = [
    {
      "date": "2024/09/08",
      "cdr": 0,
      "correctRate": 87,
      "correctCount": 5,
      "totalCount": 10,
      "hintCount": 1
    },
    {
      "date": "2024/09/07",
      "cdr": 1.5,
      "correctRate": 65,
      "correctCount": 3,
      "totalCount": 10,
      "hintCount": 2
    },
    {
      "date": "2024/09/06",
      "cdr": 1,
      "correctRate": 65,
      "correctCount": 3,
      "totalCount": 10,
      "hintCount": 2
    },
    {
      "date": "2024/09/05",
      "cdr": 0,
      "correctRate": 65,
      "correctCount": 3,
      "totalCount": 10,
      "hintCount": 2
    },
    {
      "date": "2024/09/04",
      "cdr": 1.5,
      "correctRate": 65,
      "correctCount": 3,
      "totalCount": 10,
      "hintCount": 2
    },
    // Add more items here...
  ];

  MemoryscoreDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.mainWhite,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TitleWidget(
              backgroundColor: Pallete.mainBlue,
              text: '기억점수 살펴보기',
              textColor: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            ...scoreData.map((data) {
              return MemoryScoreCard(data: data);
            }),
          ],
        ),
      ),
    );
  }
}

class MemoryScoreCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const MemoryScoreCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
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
                data['date'],
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
                          text: "${data['cdr']}",
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
                        '${data['correctRate']}%',
                        style: const TextStyle(
                          fontSize: 35,
                          fontFamily: "IBMPlexSansKRRegular",
                          color: Pallete.mainBlack,
                        ),
                      ),
                      Text(
                        '정답률 (${data['correctCount']}문제/${data['totalCount']}문제)',
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
