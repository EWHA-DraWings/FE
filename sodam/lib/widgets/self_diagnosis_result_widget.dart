import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

class SelfDiagnosisResultWidget extends StatelessWidget {
  final int score;
  final String name;
  final bool isElderly;
  const SelfDiagnosisResultWidget(
      {super.key,
      required this.score,
      required this.name,
      required this.isElderly});

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
              child: isElderly
                  ? Center(
                      //PRMQ 커트라인 31.5
                      child: (score < 31.5)
                          ? Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontFamily: 'IBMPlexSansKRRegular',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '님은\n 검사 결과\n',
                                    style: TextStyle(
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
                                    text: '으로\n기억력에는 문제가 없어보여요.',
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
                            )
                          : Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontFamily: 'IBMPlexSansKRRegular',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '님은\nPRMQ 검사 결과\n',
                                    style: TextStyle(
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
                                    text: '으로\n',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontFamily: 'IBMPlexSansKRRegular',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '인지 기능 저하',
                                    style: TextStyle(
                                      color: Color(0xFFE45959),
                                      fontSize: 30,
                                      fontFamily: 'IBMPlexSansKRRegular',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '가\n',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontFamily: 'IBMPlexSansKRRegular',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '의심',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 247, 151, 41),
                                      fontSize: 30,
                                      fontFamily: 'IBMPlexSansKRRegular',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '됩니다.',
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
                    )
                  : Center(
                      //KDSQ 커트라인 6
                      child: (score < 6)
                          ? Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontFamily: 'IBMPlexSansKRRegular',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '님은\n KDSQ검사 결과\n',
                                    style: TextStyle(
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
                                    text: '으로\n기억력에는 문제가 없어보여요.',
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
                            )
                          : Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontFamily: 'IBMPlexSansKRRegular',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '님은\nKDSQ 검사 결과\n',
                                    style: TextStyle(
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
                                    text: '으로\n',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontFamily: 'IBMPlexSansKRRegular',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '인지 기능 저하',
                                    style: TextStyle(
                                      color: Color(0xFFE45959),
                                      fontSize: 30,
                                      fontFamily: 'IBMPlexSansKRRegular',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '가\n',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontFamily: 'IBMPlexSansKRRegular',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '의심',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 247, 151, 41),
                                      fontSize: 30,
                                      fontFamily: 'IBMPlexSansKRRegular',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '됩니다.',
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
                child:
                    ((isElderly && score < 31.5) || (!isElderly && score < 6))
                        ? const SizedBox(
                            width: double.infinity,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        '꾸준한 두뇌 활동이\n치매 예방에 큰 도움이 됩니다.\n현재의 건강 상태를\n잘 유지해 나갈 수 있도록\n',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'IBMPlexSansKRRegular',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '소담',
                                    style: TextStyle(
                                      color: Pallete.sodamButtonGreen,
                                      fontSize: 25,
                                      fontFamily: 'IBMPlexSansKRBold',
                                      height: 0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '이 도와드릴게요!',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'IBMPlexSansKRRegular',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
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
                                      color: Pallete.sodamButtonGreen,
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
