import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sodam/global.dart';
import 'package:sodam/models/emotion_data.dart';
import 'package:sodam/models/login_data.dart';
import 'package:sodam/models/memory_score_data.dart';
import 'package:sodam/models/report_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/report/widget/todays_report_widget.dart';
import 'package:sodam/screens/report/past_report.dart';
import 'package:sodam/screens/self_diagnosis/guardian_diagnosis_screen.dart';
import 'package:http/http.dart' as http;

class ReportMainScreen extends StatefulWidget {
  final String name;
  final int daysPast; //마지막 자가진단 시점
  final ReportData todaysReport; //오늘 리포트

  const ReportMainScreen({
    super.key,
    required this.name,
    required this.daysPast,
    required this.todaysReport,
  });

  @override
  State<ReportMainScreen> createState() => _ReportMainScreenState();
}

class _ReportMainScreenState extends State<ReportMainScreen> {
  final ScrollController _scrollController = ScrollController();
  List<ReportData> pastReports =
      []; //=getPastReports(context); //과거 리포트(3개) -> 가져오는 함수 작성해야함
  List<MemoryScoreData> memoryScores = []; //최근 5개 기억점수

  //과거 리포트까지 가져오기
  Future<List<ReportData>> getPastReports(BuildContext context) async {
    final loginDataProvider =
        Provider.of<LoginDataProvider>(context, listen: false);
    final token = loginDataProvider.loginData?.token;

    //리포트 가져오기(오늘+ 과거 3개)
    final url = Uri.parse('http://${Global.ipAddr}:3000/api/reports');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      // json 데이터를 List<Map<String, dynamic>>로 디코딩
      final List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(jsonDecode(response.body));

      // List<Map<String, dynamic>>를 List<ReportData>로 변환
      final List<ReportData> reports =
          data.map((json) => ReportData.fromJsonToday(json)).toList();
      print(reports);
      //생성.조회한 리포트 가져오기
      return reports;
    } else {
      //500
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('500: 리포트 조회에 실패했습니다.')),
      );
      return [];
    }
  }

  //getPastReports 이용해서 pastReports에 저장
  Future<void> fetchPastReports() async {
    final reports = await getPastReports(context);
    setState(() {
      pastReports = reports;
    });
  }

  //최근 5개 기억점수 가져오기
  Future<List<MemoryScoreData>> getMemoryScores(BuildContext context) async {
    final loginDataProvider =
        Provider.of<LoginDataProvider>(context, listen: false);
    final token = loginDataProvider.loginData?.token;

    //리포트 가져오기(오늘+ 과거 3개)
    final url =
        Uri.parse('http://${Global.ipAddr}:3000/api/findmemoryscore/latest');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      //json -> memory score data list로
      final Map<String, dynamic> data = jsonDecode(response.body);
      //List<dynamic> 반환
      final List<dynamic> scoresList = data['scores'];
      final List<MemoryScoreData> memoryScores =
          scoresList.map((score) => MemoryScoreData.fromJson(score)).toList();
      return memoryScores;
    } else if (response.statusCode == 404) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('기억 점수 측정 내역이 없습니다.')),
      );
      return [];
    } else if (response.statusCode == 403) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('조회 권한이 없는 기억 점수입니다.')),
      );
      return [];
    } else {
      //500
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('500: 기억 점수 조회를 실패했습니다.')),
      );
      return [];
    }
  }

  //getMemoryScores 이용해서 memoryScores에 저장
  Future<void> fetchMemoryScores() async {
    final scores = await getMemoryScores(context);
    setState(() {
      memoryScores = scores;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPastReports();
    fetchMemoryScores();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double greenContainerHeight = 160; // 그린 컨테이너의 높이
    double greenContainerFromTop = 170; //그린컨테이너의 top으로부터 거리

    //emotion data(오늘 감정)
    final List<EmotionData> emotions = widget.todaysReport.emotions;

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
                          '${widget.name}님!',
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
                    '마지막으로 자가진단을 하신지\n${widget.daysPast}일이 지났어요!', //여기도 날짜 추가해야 됨
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
                        condition: widget.todaysReport.condition, //오늘 컨디션
                        emotions: emotions, //오늘의 감정
                        memoryScoreDatas: memoryScores, //기억 점수
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
                                  child: pastReports.isNotEmpty &&
                                          pastReports.length > 1
                                      ? PastReport(
                                          name: widget.name,
                                          condition: pastReports[1].condition,
                                          memoryScore: 10,
                                          //pastReports[1].correctRatio.toDouble(),
                                          emotions: pastReports[1].emotions,
                                        )
                                      : const Text('과거 리포트가 없습니다.'),
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
                                  child: pastReports.length > 2
                                      ? PastReport(
                                          name: widget.name,
                                          condition: pastReports[2].condition,
                                          memoryScore: 2,
                                          //pastReports[2].correctRatio,
                                          emotions: pastReports[2].emotions,
                                        )
                                      : const Text('과거 리포트가 없습니다.'),
                                ),
                              ),
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
