import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:sodam/global.dart';
import 'package:sodam/models/login_data.dart';
import 'package:sodam/pallete.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiaryScreen extends StatefulWidget {
  final DateTime date;
  final String content; //content가 null일 시 일기 없다는 메시지 전달되도록 수정 필요

  const DiaryScreen({super.key, required this.date, required this.content});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final FlutterTts flutterTts = FlutterTts();
  late TextEditingController _contentController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _contentController =
        TextEditingController(text: widget.content); //content null일 시 ""로 ���기화
  }

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
    _contentController.dispose();
    super.dispose();
  }

  //수정하기 기능
  Future<void> _editContent() async {
    setState(() {
      _isEditing = true;
    });

    final String? editedContent = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("일기 수정"),
          content: TextField(
            controller: _contentController,
            maxLines: null,
            decoration: const InputDecoration(hintText: "일기 내용을 입력하세요"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text("취소"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, _contentController.text),
              child: const Text("저장"),
            ),
          ],
        );
      },
    );

    if (editedContent != null) {
      setState(() {
        _isEditing = false;
      });
      //await _saveContentToBackend(editedContent);
    } else {
      setState(() {
        _isEditing = false;
      });
    }
  }

  // Future<void> _saveContentToBackend(String content) async {
  //   // 여기서 백엔드로 데이터를 전송하는 코드를 구현하세요.
  //   // 예시: 백엔드 API 요청을 보내는 코드 추가
  //   print("저장된 내용: $content"); // 실제로는 백엔드에 요청을 보냄
  //   // /api/diary/:diaryId(diaryId는 MongoDB ObjectId)
  //   final loginDataProvider =
  //       Provider.of<LoginDataProvider>(context, listen: false);
  //   final token = loginDataProvider.loginData?.token;

  //   //리포트 가져오기(오늘+ 과거 3개)
  //   final url = Uri.parse('http://${Global.ipAddr}:3000/api/diary/:diaryId');

  //   final response = await http.get(
  //     url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token'
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     // json 데이터를 List<Map<String, dynamic>>로 디코딩
  //     final List<Map<String, dynamic>> data =
  //         List<Map<String, dynamic>>.from(jsonDecode(response.body));

  //     // List<Map<String, dynamic>>를 List<ReportData>로 변환
  //     final List<ReportData> reports =
  //         data.map((json) => ReportData.fromJsonToday(json)).toList();
  //     print(reports);
  //     //생성.조회한 리포트 가져오기
  //     return reports;
  //   } else {
  //     //500
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('500: 리포트 조회에 실패했습니다.')),
  //     );
  //     return [];
  //   }
  
  // }

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
                onPressed: _editContent,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.mainBlue,
                  shape: const CircleBorder(), // 원형 버튼
                  padding: EdgeInsets.zero,
                ),
                child: Image.asset(
                  "lib/assets/images/edit.png",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
