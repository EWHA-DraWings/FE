import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

class TodaysReportWidget extends StatelessWidget {
  const TodaysReportWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const width = 220.0;
    const height = 270.0;
    const boxColor = Pallete.sodamReportBlue;

    return Row(
      children: [
        const SizedBox(width: 5),
        Container(
          width: width,
          height: height,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "2024/09/14",
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: "IBMPlexSansKRRegular",
                    color: Color.fromARGB(255, 70, 72, 88),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  "감정 분석 결과",
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "IBMPlexSansKRBold",
                      color: Colors.black),
                ),
                SizedBox(height: 15),
                Text(
                  "당황 60%",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "IBMPlexSansKRBold",
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
                Text(
                  "이어서 슬픔, 행복이 차지했어요.",
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: "IBMPlexSansKRRegular",
                    color: Colors.white,
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
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "2024/09/14",
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: "IBMPlexSansKRRegular",
                    color: Color.fromARGB(255, 70, 72, 88),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  "컨디션",
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "IBMPlexSansKRBold",
                      color: Colors.black),
                ),
                SizedBox(height: 20),
                Text(
                  "무릎이 조금 아프시지만, 잠은 잘 주무시는 편이에요. 최근 보조제를 드시고 계신다고 해요.",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "IBMPlexSansKRRegular",
                    color: Colors.white,
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
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "2024/09/14",
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: "IBMPlexSansKRRegular",
                    color: Color.fromARGB(255, 70, 72, 88),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  "기억점수",
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "IBMPlexSansKRBold",
                      color: Colors.black),
                ),
                SizedBox(height: 20),
                //기억점수 그래프
              ],
            ),
          ),
        ),
        const SizedBox(width: 5),
      ],
    );
  }
}
