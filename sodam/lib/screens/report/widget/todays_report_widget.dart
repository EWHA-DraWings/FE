import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/report/report_detail_screen.dart';
import 'package:sodam/screens/report/widget/doughnut_chart_widget.dart';
import 'package:sodam/screens/report/widget/memory_chart_widget.dart';

class TodaysReportWidget extends StatelessWidget {
  const TodaysReportWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const width = 220.0;
    const height = 270.0;
    const boxColor = Pallete.sodamReportBlue;
    const dateColor = Color.fromARGB(255, 70, 72, 88);
    const titleColor = Color.fromARGB(255, 242, 248, 255);
    const textColor = Colors.black;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const SizedBox(width: 5),
          Container(
            width: width,
            height: height,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3), // 그림자의 색상과 투명도
                  spreadRadius: 2, // 그림자의 확산 정도
                  blurRadius: 6, // 그림자의 블러 정도
                  offset: const Offset(2, 2), // 그림자의 위치 (오프셋)
                ),
              ],
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
                      color: dateColor,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "감정 분석 결과",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "IBMPlexSansKRBold",
                        color: titleColor),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "당황 60%",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "IBMPlexSansKRBold",
                      color: textColor,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "이어서 슬픔, 행복이 차지했어요.",
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: "IBMPlexSansKRRegular",
                      color: textColor,
                      height: 1.5,
                    ),
                  ),
                  DoughnutChartWidget(),
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
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3), // 그림자의 색상과 투명도
                  spreadRadius: 2, // 그림자의 확산 정도
                  blurRadius: 6, // 그림자의 블러 정도
                  offset: const Offset(2, 2), // 그림자의 위치 (오프셋)
                ),
              ],
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
                      color: dateColor,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "컨디션",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "IBMPlexSansKRBold",
                        color: titleColor),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "무릎이 조금 아프시지만, 잠은 잘 주무시는 편이에요. 최근 보조제를 드시고 계신다고 해요.",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "IBMPlexSansKRRegular",
                      color: textColor,
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
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3), // 그림자의 색상과 투명도
                  spreadRadius: 2, // 그림자의 확산 정도
                  blurRadius: 6, // 그림자의 블러 정도
                  offset: const Offset(2, 2), // 그림자의 위치 (오프셋)
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "2024/09/14",
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: "IBMPlexSansKRRegular",
                      color: dateColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    "기억점수",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "IBMPlexSansKRBold",
                        color: titleColor),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: MemoryChartWidget(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      width: 200,
                      //height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ReportDetailScreen()),
                          );
                        }, //다음 화면으로 이동
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Pallete.mainWhite,
                          backgroundColor: Pallete.mainBlue, // 버튼 배경 색상
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // 버튼 모서리 둥글기
                          ),
                        ),
                        child: const Text(
                          '자세히 살펴보기',
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'IBMPlexSansKRRegular',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}
