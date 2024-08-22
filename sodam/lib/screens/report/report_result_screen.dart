import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sodam/pallete.dart';

class ReportResultScreen extends StatelessWidget {
  const ReportResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.sodamGreen,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Pallete.sodamGreen,
        foregroundColor: Colors.white, //글씨 색
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0), // 선의 두께
          child: Container(
            color: Colors.white,
            height: 2.0, // 선의 두께
          ),
        ),
        title: const Text(
          "리포트",
          style: TextStyle(
            color: Pallete.sodamBeige,
            fontSize: 40,
            fontWeight: FontWeight.w800,
            fontFamily: "PoorStory",
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Pallete.sodamBeige,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '8월 14일',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      fontFamily: "IBMPlexSansKR",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.black, // 윤곽선 색상
                      width: 2, // 윤곽선 두께
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Center(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Text(
                          '하고 싶은 말',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w500,
                            fontFamily: "PoorStory",
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '나는 잘 지내니\n밥 잘 챙겨먹고 다녀라.\n 연락 좀 자주해라.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: "PoorStory",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    ResultTypeButton(resultType: '컨디션', isSelected: true),
                    ResultTypeButton(resultType: '감정 분석', isSelected: true),
                    ResultTypeButton(resultType: '기억 점수', isSelected: true),
                  ],
                ),
                Container(
                  height: 400,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Pallete.sodamPink, // 윤곽선 색상
                      width: 5, // 윤곽선 두께
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Center(
                    child: /*ConditionWidget(
                      user: '홍길동',
                      conditionStatus: '저녁을 드시고 소화가 안 되어\n소화제를 드셨대요.',
                    ),*/
                        EmoAnalysisWidget(
                      user: '홍길동',
                      mainEmo: '당황',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmoAnalysisWidget extends StatelessWidget {
  final String user;
  final String mainEmo; //대표 감정

  const EmoAnalysisWidget({
    super.key,
    required this.user,
    required this.mainEmo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          '$user님의 감정',
          style: const TextStyle(
            fontSize: 30,
            fontFamily: "DoHyeon",
            decoration: TextDecoration.underline, // 밑줄 추가
            decorationColor: Colors.black, // 밑줄 색상
            decorationThickness: 2, // 밑줄 두께
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '오늘의 대표 감정: $mainEmo',
          style: const TextStyle(
            fontSize: 26,
            fontFamily: "PoorStory",
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          '감정 분석 Top3',
          style: TextStyle(
            fontSize: 26,
            fontFamily: "PoorStory",
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