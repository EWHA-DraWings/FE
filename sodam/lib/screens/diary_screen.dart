import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:sodam/pallete.dart';

class DiaryScreen extends StatefulWidget {
  final DateTime date;
  final String content; //content가 null일 시 일기 없다는 메시지 전달되도록 수정 필요

  const DiaryScreen({super.key, required this.date, required this.content});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final FlutterTts flutterTts = FlutterTts();

  //tts 기본 설정
  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("ko-KR");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    //화면 닫으면 tts 중지
    flutterTts.stop(); //tts 중지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    //달력 날짜 처리용
    int month = widget.date.month;
    int day = widget.date.day;

    int weekdayIndex = widget.date.weekday;
    List<String> weekdays = [
      '월요일',
      '화요일',
      '수요일',
      '목요일',
      '금요일',
      '토요일',
      '일요일',
    ];
    //날짜 요일 처리
    String weekday = weekdays[weekdayIndex - 1];

    return Scaffold(
      backgroundColor: Pallete.mainWhite,
      appBar: AppBar(
        backgroundColor: Pallete.mainWhite,
        scrolledUnderElevation: 0, //스크롤 시 appbar 색상이 바뀌는 점 해결.
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.08),
                    child: Text(
                      "$month월 $day일 $weekday",
                      style: const TextStyle(
                        fontFamily: "IBMPlexSansKRRegular",
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.05),
                    child: TextButton(
                      //일기 내용 읽어주는 버튼
                      onPressed: () => _speak(widget.content),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                      ),
                      child: Image.asset(
                        "lib/assets/images/listen.png",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.75,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: Pallete.mainGray,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Text(
                      widget.content,
                      style: const TextStyle(
                        fontFamily: "IBMPlexSansKRRegular",
                        fontSize: 25,
                        height: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            // Container 위에 약간 겹치도록 조정
            bottom: screenHeight * 0.03,
            right: screenWidth * 0.03,
            child: SizedBox(
              width: 75,
              height: 75,
              child: ElevatedButton(
                onPressed: () {
                  // 버튼 클릭 시 동작. 나중에 수정필요
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.mainBlue,
                  shape: const CircleBorder(), // 원형 버튼
                  padding: EdgeInsets.zero,
                ),
                child: Image.asset(
                  "lib/assets/images/edit.png",
                  //width: 70, 왜 너비를 줘도 안먹는지 모르겠음.
                  //height: 70,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
