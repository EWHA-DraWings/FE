import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/report/todays_report_widget.dart';
import 'package:sodam/screens/self_diagnosis/guardian_diagnosis_screen.dart';

class ReportMainScreen extends StatelessWidget {
  const ReportMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double greenContainerHeight = 160; // 그린 컨테이너의 높이
    double greenContainerFromTop = 170; //그린컨테이너의 top으로부터 거리
    return Scaffold(
      body: Stack(
        //스택으로 appbar보다 컨테이너가 위에 위치하도록 설정
        children: [
          Column(
            children: [
              AppBar(
                flexibleSpace: Container(
                  height: 250,
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Pallete.mainBlue,
                        Color.fromARGB(255, 186, 185, 195),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 80,
                      left: screenWidth * 0.14,
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 3),
                          child: Text(
                            "안녕하세요,",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "IBMPlexSansKRBold",
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          "홍길동님!",
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: "IBMPlexSansKRBold",
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                scrolledUnderElevation: 0,
              ),
            ],
          ),
          Positioned(
            top: 70,
            right: screenWidth * 0.14,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.transparent,
              ),
              child: ClipOval(
                child: Image.asset(
                  'lib/assets/images/humanphoto.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Overlay Container
          Positioned(
            top: greenContainerFromTop, // AppBar와 겹치도록 위치 조정
            left: screenWidth * 0.09,
            right: screenWidth * 0.09,
            child: Container(
              height: greenContainerHeight,
              width: screenWidth * 0.6,
              decoration: BoxDecoration(
                color: Pallete.sodamReportGreen,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '마지막으로 자가진단을 하신지\n30일이 지났어요!', //여기도 날짜 추가해야 됨
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: "IBMPlexSansKRRegular",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const GuardianDiagnosisScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ), // 버튼 안쪽 여백
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '자가진단 하러가기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: "IBMPlexSansKRRegular",
                            ),
                          ),
                          const SizedBox(width: 10),
                          Image.asset(
                            'lib/assets/images/click.png', // 이미지 경로
                            width: 30,
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            child: Container(),
          ),
          Positioned(
            top: greenContainerFromTop + greenContainerHeight,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: SizedBox(
                height:
                    screenHeight - greenContainerFromTop + greenContainerHeight,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 22),
                      child: Text(
                        "오늘의 리포트",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: TodaysReportWidget(),
                    ),
                    //여기다가 리포트 추가하면 됨
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
