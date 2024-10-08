import 'package:flutter/material.dart';
import 'package:sodam/models/emotion_data.dart';
import 'package:sodam/models/memory_score_data.dart';
import 'package:sodam/models/report_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/report/widget/todays_report_widget.dart';
import 'package:sodam/screens/report/past_report.dart';
import 'package:sodam/screens/self_diagnosis/guardian_diagnosis_screen.dart';

class ReportMainScreen extends StatelessWidget {
  final String name;
  final int daysPast; //마지막 자가진단 시점
  final ReportData todaysReport; //오늘 리포트
  final List<ReportData> pastReports; //과거 리포트

  ReportMainScreen(
      {super.key,
      required this.name,
      required this.daysPast,
      required this.todaysReport,
      required this.pastReports});
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double greenContainerHeight = 160; // 그린 컨테이너의 높이
    double greenContainerFromTop = 170; //그린컨테이너의 top으로부터 거리

    //emotion data(오늘 감정)
    final List<EmotionData> emotions = todaysReport.emotions;

    final List<ReportData> pastReports; //과거 리포트(3개) -> 가져오는 함수 작성해야함

    // 각 ExpansionTile에 사용할 GlobalKey를 생성합니다.
    final GlobalKey expansionTileKey1 = GlobalKey();
    final GlobalKey expansionTileKey2 = GlobalKey();

    // 스크롤 포지션을 계산하고 해당 위치로 스크롤하는 함수
    void scrollToPosition(GlobalKey key) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final context = key.currentContext;
        if (context != null) {
          final box = context.findRenderObject() as RenderBox?;
          if (box != null) {
            final position = box.localToGlobal(Offset.zero).dy;
            _scrollController.animateTo(
              _scrollController.offset + position - 100, // 위치 조정
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        }
      });
    }

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
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
                          '$name님!',
                          style: const TextStyle(
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
                  Text(
                    '마지막으로 자가진단을 하신지\n$daysPast일이 지났어요!', //여기도 날짜 추가해야 됨
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
            bottom: 0,
            child: SingleChildScrollView(
              controller: _scrollController, // ScrollController 추가
              child: SizedBox(
                //height:screenHeight - greenContainerFromTop + greenContainerHeight,// scroll을 감싸는 sized box에 높이를 줘가지고 overflow 발생한 것.
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 22),
                      child: Text(
                        "오늘의 리포트",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: TodaysReportWidget(
                        condition: todaysReport.condition, //오늘 컨디션
                        emotions: emotions, //오늘의 감정
                        memoryScoreDatas: [
                          MemoryScoreData(
                              date: '2023-08-25', score: 100, cdr: 1),
                          MemoryScoreData(
                              date: '2023-08-28', score: 98.1, cdr: 1),
                          MemoryScoreData(
                              date: '2023-09-03', score: 70, cdr: 1),
                          MemoryScoreData(
                              date: '2023-09-06', score: 66.6, cdr: 1),
                          MemoryScoreData(
                              date: '2023-09-09', score: 79, cdr: 1),
                          MemoryScoreData(
                              date: '2023-09-12', score: 86, cdr: 1),
                          MemoryScoreData(
                              date: '2023-09-15', score: 83.2, cdr: 1),
                          MemoryScoreData(
                              date: '2023-09-18', score: 81, cdr: 1),
                          MemoryScoreData(
                              date: '2023-09-21', score: 93, cdr: 1),
                          MemoryScoreData(
                              date: '2023-09-24', score: 91.3, cdr: 1),
                          MemoryScoreData(
                              date: '2023-09-27', score: 92, cdr: 1),
                        ],
                      ),
                    ),
                    //여기다가 리포트 추가하면 됨
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 22),
                      child: Text(
                        "과거 리포트 살펴보기",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        children: [
                          ExpansionTile(
                            shape: RoundedRectangleBorder(
                              //펼쳤을 때
                              borderRadius: BorderRadius.circular(10),
                            ),
                            collapsedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: const Text('2024/09/08'),
                            collapsedBackgroundColor: Pallete.sodamReportPurple,
                            backgroundColor: Pallete.sodamReportPurple,
                            children: <Widget>[
                              SizedBox(
                                height: 300,
                                child: SingleChildScrollView(
                                  child: PastReport(
                                    name: name,
                                    condition:
                                        '무릎이 조금 아프시지만, 잠은 잘 \n주무시는 편이에요. 최근 보조제를\n드시고 계신다고 해요.',
                                    memoryScore: 77.2,
                                    emotions: [
                                      EmotionData(
                                          emotion: '당황', percentage: 80.0),
                                      EmotionData(
                                          emotion: '불안', percentage: 13.0),
                                      EmotionData(
                                          emotion: '행복', percentage: 7.0),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            onExpansionChanged: (value) {
                              if (value) {
                                // ExpansionTile이 열릴 때 스크롤
                                scrollToPosition(expansionTileKey1);
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          ExpansionTile(
                            shape: RoundedRectangleBorder(
                              //펼쳤을 때
                              borderRadius: BorderRadius.circular(10),
                            ),
                            collapsedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: const Text('2024/09/07'),
                            collapsedBackgroundColor: Pallete.sodamReportPurple,
                            backgroundColor: Pallete.sodamReportPurple,
                            children: <Widget>[
                              SizedBox(
                                  height: 300,
                                  child: SingleChildScrollView(
                                    child: PastReport(
                                      name: name,
                                      condition:
                                          '무릎이 조금 아프시지만, 잠은 잘 \n주무시는 편이에요. 최근 보조제를\n드시고 계신다고 해요.',
                                      memoryScore: 80.6,
                                      emotions: [
                                        EmotionData(
                                            emotion: '슬픔', percentage: 50.0),
                                        EmotionData(
                                            emotion: '행복', percentage: 40.0),
                                        EmotionData(
                                            emotion: '분노', percentage: 10.0),
                                      ],
                                    ),
                                  )),
                            ],
                            onExpansionChanged: (value) {
                              if (value) {
                                // ExpansionTile이 열릴 때 스크롤
                                scrollToPosition(expansionTileKey2);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
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
