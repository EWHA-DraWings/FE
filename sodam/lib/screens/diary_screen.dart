import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:sodam/global.dart';
import 'package:sodam/models/login_data.dart';
import 'package:sodam/pallete.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiaryScreen extends StatefulWidget {
  final String diaryId;
  final DateTime date;
  final String content; //content가 null일 시 일기 없다는 메시지 전달되도록 수정 필요

  const DiaryScreen(
      {super.key,
      required this.date,
      required this.content,
      required this.diaryId});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final FlutterTts flutterTts = FlutterTts();
  late TextEditingController _contentController;
  bool _isEditing = false; // 편집 여부 상태
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.content);
    _focusNode = FocusNode();
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("ko-KR");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    flutterTts.stop();
    _contentController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // 일기 내용 저장
  Future<void> _saveContentToBackend(String content) async {
    print("저장된 내용: $content");
    final loginDataProvider =
        Provider.of<LoginDataProvider>(context, listen: false);
    final token = loginDataProvider.loginData?.token;

    final url =
        Uri.parse('http://${Global.ipAddr}:3000/api/diary/${widget.diaryId}');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({'content': content}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        String updatedContent = responseData['updatedDiary']['content'];
        setState(() {
          _contentController.text = updatedContent;
          _isEditing = false; // 편집 완료 후 수정 상태 종료
        });
      } else {
        print("에러 발생: ${response.statusCode}");
      }
    } catch (error) {
      print("HTTP 요청 중 에러 발생: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    int month = widget.date.month;
    int day = widget.date.day;
    int weekdayIndex = widget.date.weekday;
    List<String> weekdays = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];
    String weekday = weekdays[weekdayIndex - 1];

    return Scaffold(
      backgroundColor: Pallete.mainWhite,
      appBar: AppBar(
        backgroundColor: Pallete.mainWhite,
        scrolledUnderElevation: 0,
      ),
      resizeToAvoidBottomInset: true, // 키보드가 올라왔을 때 화면 조정 활성화
      body: SingleChildScrollView(
        child: Column(
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
                    onPressed: () => _speak(widget.content),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                    ),
                    child: Image.asset("lib/assets/images/listen.png"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.75,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              decoration: BoxDecoration(
                color: Pallete.mainGray,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: _isEditing // 수정 모드
                    ? SingleChildScrollView(
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).requestFocus(_focusNode);
                          },
                          child: TextField(
                            controller: _contentController,
                            focusNode: _focusNode,
                            maxLines: null,
                            style: const TextStyle(
                              fontFamily: "IBMPlexSansKRRegular",
                              fontSize: 25,
                              height: 2.0,
                            ),
                            decoration: const InputDecoration(
                              hintText: "일기 내용을 입력하세요",
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10.0),
                            ),
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Text(
                          _contentController.text,
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
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {
            if (_isEditing) {
              _saveContentToBackend(_contentController.text);
            } else {
              setState(() {
                _isEditing = true;
              });
            }
          },
          backgroundColor: Pallete.mainBlue,
          shape: const CircleBorder(),
          child: _isEditing
              ? Image.asset("lib/assets/images/save.png", width: 45, height: 45)
              : Image.asset("lib/assets/images/edit.png",
                  width: 45, height: 45),
        ),
      ),
    );
  }
}
