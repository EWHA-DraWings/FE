import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

class SelfDiagnosisResultWidget extends StatelessWidget {
  final int score;
  final String name;
  const SelfDiagnosisResultWidget(
      {super.key, required this.score, required this.name});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 25,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Center(
                child: (score < 6)
                    ? Text(
                        """총점 : $score점\n""",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: "IBMPlexSansKRRegular",
                        ),
                      )
                    : Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '$name님은 \n',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontFamily: 'IBMPlexSansKRRegular',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            TextSpan(
                              text: '총점 $score점',
                              style: const TextStyle(
                                color: Pallete.mainBlue,
                                fontSize: 30,
                                fontFamily: 'IBMPlexSansKRRegular',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            const TextSpan(
                              text: '으로 \n현재 치매 선별 검사가 \n',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontFamily: 'IBMPlexSansKRRegular',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            const TextSpan(
                              text: '필요한',
                              style: TextStyle(
                                color: Color(0xFFE45959),
                                fontSize: 30,
                                fontFamily: 'IBMPlexSansKRRegular',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            const TextSpan(
                              text: ' 상태에요.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontFamily: 'IBMPlexSansKRRegular',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: (score < 6)
                    ? Text(
                        """총점 : $score점\n""",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "IBMPlexSansKRRegular",
                        ),
                      )
                    : const SizedBox(
                        width: double.infinity,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    '신경과 전문의를 통해\n초기에 진단된다면 \n치료를 통해 진행을 늦추거나 종류에\n 따라서는 완치까지도 가능하므로 \n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'IBMPlexSansKRRegular',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              TextSpan(
                                text: '병원에 방문해보세요!',
                                style: TextStyle(
                                  color: Pallete.sodamButtonDarkGreen,
                                  fontSize: 25,
                                  fontFamily: 'IBMPlexSansKRBold',
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
