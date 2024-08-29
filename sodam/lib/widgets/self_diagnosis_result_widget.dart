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
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              width: double.infinity,
              height: 200,
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
                          fontSize: 25,
                          fontFamily: "IBMPlexSansKRRegular",
                        ),
                      )
                    : const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '홍길동님은 \n',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontFamily: 'IBMPlexSansKRRegular',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            TextSpan(
                              text: '총점 10점',
                              style: TextStyle(
                                color: Pallete.sodamOrange,
                                fontSize: 30,
                                fontFamily: 'IBMPlexSansKRBold',
                                height: 0,
                              ),
                            ),
                            TextSpan(
                              text: '으로 \n현재 치매 선별 검사가 \n',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontFamily: 'IBMPlexSansKRRegular',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            TextSpan(
                              text: '필요한',
                              style: TextStyle(
                                color: Color(0xFFBF587D),
                                fontSize: 30,
                                fontFamily: 'IBMPlexSansKRBold',
                                height: 0,
                              ),
                            ),
                            TextSpan(
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
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              width: double.infinity,
              height: 220,
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
                        width: 318,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    '신경과 전문의를 통해 \n초기에 진단된다면 \n치료를 통해 진행을 늦추거나 \n종류에 따라서는 \n완치까지도 가능하므로 \n',
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
                                  color: Color(0xFF5BB287),
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
