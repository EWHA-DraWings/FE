import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sodam/models/self_diagnosis_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/widgets/title_widget.dart';

class SelfDiagnosisDetailScreen extends StatelessWidget {
  final List<SelfDiagnosisData> selfDiagnosisDatas;

  const SelfDiagnosisDetailScreen(
      {super.key, required this.selfDiagnosisDatas});

  @override
  Widget build(BuildContext context) {
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
            text: '자가진단 살펴보기',
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
              itemCount: selfDiagnosisDatas.length,
              itemBuilder: (context, index) {
                final data = selfDiagnosisDatas[index];
                return SelfDiagnosisScoreCard(data: data);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SelfDiagnosisScoreCard extends StatelessWidget {
  final SelfDiagnosisData data;

  const SelfDiagnosisScoreCard({super.key, required this.data});

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
                  const Spacer(),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${data.type}  ",
                          style: const TextStyle(
                            fontSize: 30,
                            fontFamily: "IBMPlexSansKRBold",
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "${data.score}",
                          style: TextStyle(
                            fontSize: 47,
                            fontFamily: "IBMPlexSansKRBold",
                            color:
                                ((data.type == 'PRMQ' && data.score < 31.5) ||
                                        (data.type == 'KDSQ' && data.score < 6))
                                    ? Pallete.mainBlue
                                    : const Color.fromARGB(255, 237, 86, 41),
                          ),
                        ),
                        TextSpan(
                          text: data.type == 'PRMQ' ? "/80" : "/30",
                          style: const TextStyle(
                            fontSize: 28,
                            fontFamily: "IBMPlexSansKRRegular",
                            color: Pallete.mainBlack,
                          ),
                        ),
                      ],
                    ),
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
