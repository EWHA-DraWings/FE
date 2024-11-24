import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sodam/global.dart';
import 'package:sodam/models/emotion_data.dart';
import 'package:sodam/models/login_data.dart';
import 'package:sodam/models/memory_score_data.dart';
import 'package:sodam/models/report_data.dart';
import 'package:sodam/models/self_diagnosis_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/report/widget/past_report_tile.dart';
import 'package:sodam/screens/report/widget/todays_report_widget.dart';
import 'package:sodam/screens/self_diagnosis/guardian_diagnosis_screen.dart';
import 'package:http/http.dart' as http;
import 'package:sodam/screens/self_diagnosis/user_diagnosis_screen.dart'; //http 가져오기

class ReportMainScreen extends StatefulWidget {
  final String name;

  const ReportMainScreen({
    super.key,
    required this.name,
  });

  @override
  State<ReportMainScreen> createState() => _ReportMainScreenState();
}

class _ReportMainScreenState extends State<ReportMainScreen> {
  final ScrollController _scrollController = ScrollController();
  Map<String, dynamic> todaysReport = {}; //오늘 리포트
  List<MemoryScoreData> memoryScores = []; //기억점수
  List<SelfDiagnosisData> selfDiagnosisDatas = []; //자가진단
  List<ReportData> pastReports = []; //과거 리포트
  bool isLoading = true; //로딩 상태

  @override
  void initState() {
    super.initState();
    final loginDataProvider =
        Provider.of<LoginDataProvider>(context, listen: false);
    final jwtToken = loginDataProvider.loginData?.token;
    getTodaysReport(jwtToken);
    getMemoryScores(jwtToken);
    getPastReports(jwtToken);
    getSelfDiagnosisScores(jwtToken);
  }

  //오늘 리포트 가져오기
  Future<void> getTodaysReport(jwtToken) async {
    ///api/reports/:date (2024-09-30 형식)
    //오늘 날짜 형태 바꾸기
    DateTime now = DateTime.now();
    String today = DateFormat('yyyy-MM-dd').format(now);
    print(today);

    final url = Uri.parse('http://${Global.ipAddr}:3000/api/reports/$today');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken'
      },
    );

    if (response.statusCode == 200) {
      //JSON 응답 파싱
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        todaysReport = data;
      });
    } else if (response.statusCode == 400) {
      //해당 날짜 일기X
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('해당 날짜에 일기가 존재하지 않습니다.')),
      );
    } else {
      //500: 리포트 조회.생성 실패
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('500: 리포트 생성 또는 조회에 실패했습니다.')),
      );
    }
  }

  //기억점수 최근 5개 가져오기
  Future<void> getMemoryScores(jwtToken) async {
    final url =
        Uri.parse('http://${Global.ipAddr}:3000/api/findmemoryscore/latest');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken'
      },
    );

    if (response.statusCode == 200) {
      //JSON 응답 파싱
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        memoryScores = MemoryScoreData.fromJsonList(data['scores']);
      });
      for (var data in memoryScores) {
        print(data);
      }
    } else if (response.statusCode == 404) {
      //기억점수 내역X
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('기억 점수 측정 내역이 없습니다.')),
      );
    } else if (response.statusCode == 403) {
      //해당 날짜 일기X
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('조회 권한이 없습니다.')),
      );
    } else {
      //500: 기억점수 조회 실패
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('500: 기억점수 불러오기를 실패했습니다.')),
      );
    }
  }

  //자가진단 기록 가져오기
  Future<void> getSelfDiagnosisScores(jwtToken) async {
    final url = Uri.parse('http://${Global.ipAddr}:3000/api/assessments/user');
    print(url);
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken'
      },
    );

    if (response.statusCode == 200) {
      //JSON 응답 파싱
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        selfDiagnosisDatas = SelfDiagnosisData.fromJsonList(data['data']);
        isLoading = false;
      });
      for (var data in selfDiagnosisDatas) {
        print(data);
      }
    } else if (response.statusCode == 404) {
      //자가진단 내역X
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('자가진단 결과가 없습니다.')),
      );
    } else {
      //500: 자가진단 결과 조회 실패
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('500: 자가진단 데이터 불러오기를 실패했습니다.')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  //과거 리포트 가져오기
  Future<void> getPastReports(jwtToken) async {
    final url = Uri.parse('http://${Global.ipAddr}:3000/api/reports');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken'
      },
    );

    if (response.statusCode == 200) {
      //JSON 응답 파싱
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        pastReports = ReportData.fromJsonList(data);
        print('past report:$pastReports');
      });
    } else {
      //response.statusCode == 500
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('500: 리포트 조회 중 오류가 발생했습니다. 다시 시도해주세요.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double greenContainerHeight = 160; // 그린 컨테이너의 높이
    double greenContainerFromTop = 170; //그린컨테이너의 top으로부터 거리

    // emotions 객체 추출
    var emotionsMap = todaysReport['emotions'];
    print('emotionsMap:$emotionsMap');

    List<EmotionData> emotions = [];
    if (emotionsMap != null && emotionsMap.isNotEmpty) {
      emotionsMap.forEach((emotion, percentage) {
        emotions.add(
            EmotionData(emotion: emotion, percentage: percentage.toDouble()));
      });
    } else {
      emotions.add(EmotionData(emotion: "결과 없음", percentage: 100));
      print('emotions is null or empty');
    }
    // percentage를 기준으로 내림차순 정렬
    emotions.sort((a, b) => b.percentage.compareTo(a.percentage));
    print('emotions: $emotions');

    //날짜 내림차순
    selfDiagnosisDatas.sort(
      (a, b) => b.date.compareTo(a.date),
    );

    DateTime lastDiagnosisDate;
    int daysPast = 0;

    if (selfDiagnosisDatas.isNotEmpty) {
      lastDiagnosisDate =
          DateTime.parse(selfDiagnosisDatas[0].date); //마지막 자가진단 시점
      DateTime todayDate = DateTime.now();
      daysPast = todayDate.difference(lastDiagnosisDate).inDays;
    } else {
      lastDiagnosisDate = DateTime.now();
      daysPast = 0; // 자가진단 데이터가 없을 경우, daysPast를 0으로 설정
    }

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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
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
                          daysPast > 0
                              ? '마지막으로 자가진단을 하신지\n$daysPast일이 지났어요!'
                              : '',
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
                                        const UserDiagnosisScreen()),
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
                    child: CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 22),
                                child: Text(
                                  "오늘의 리포트",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                              TodaysReportWidget(
                                condition: todaysReport['conditions'] ??
                                    '컨디션 기록이 없어요!',
                                emotions: emotions,
                                memoryScoreDatas: memoryScores,
                                selfDiagnosisDatas: selfDiagnosisDatas,
                              ),
                            ],
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 22),
                            child: Text(
                              "과거 리포트 살펴보기",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: PastReportTile(
                                  date: pastReports[index].date,
                                  condition: pastReports[index].condition,
                                  memoryScore: pastReports[index].correctRatio,
                                  emotions: pastReports[index].emotions,
                                  expansionTileKey: GlobalKey(),
                                  scrollToPosition: scrollToPosition,
                                ),
                              );
                            },
                            childCount: pastReports.length,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
    );
  }
}
