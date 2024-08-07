import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

class GuardianTotalscoreScreen extends StatelessWidget {
  final int score;
  const GuardianTotalscoreScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.sodamGreen,
      appBar: AppBar(
        backgroundColor: Pallete.sodamGreen,
        foregroundColor: Pallete.sodamBeige, //글씨 색
        title: const Center(
          child: Text(
            "진단 결과",
            style: TextStyle(
              fontSize: 24,
              fontFamily: "Gugi",
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              ResultWidget(score: score),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultWidget extends StatelessWidget {
  final int score;
  const ResultWidget({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Pallete.sodamGray,
              ),
              child: const Center(
                child: Text(
                  "000님의 자가진단 결과",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: "IBMPlexSansKRRegular",
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 30,
                  ),
                  child: (score < 6)
                      ? Text(
                          """총점 : $score점\n""",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: "IBMPlexSansKRRegular",
                          ),
                        )
                      : Text(
                          """총점 : $score점\n
\t000님은 자가진단에 의하면 현재 치매 선별 검사가 필요한 상태에요.\n
\t신경과 전문의를 통해 초기에 진단된다면 치료를 통해 진행을 늦추거나 종류에 따라서는 완치까지도 가능하므로 병원에 방문해보세요!""",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: "IBMPlexSansKRRegular",
                          ),
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
              onPressed: () {}, //나중에 함수 추가하기
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.black.withOpacity(0.2),
              ),
              child: const Text(
                '결과 공유하기',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
              onPressed: () {}, //나중에 함수 추가하기
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.black.withOpacity(0.2),
              ),
              child: const Text(
                '가까운 병원 살펴보기',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
              onPressed: () {}, //나중에 함수 추가하기
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.black.withOpacity(0.2),
              ),
              child: const Text(
                '기억점수 기록 살펴보기',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
