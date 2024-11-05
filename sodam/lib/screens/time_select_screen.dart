import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:provider/provider.dart';
import 'package:sodam/global.dart';
import 'package:sodam/models/login_data.dart';
import 'package:sodam/pallete.dart';
import 'package:http/http.dart' as http;
import 'package:sodam/screens/login_screen.dart';

class TimeSelectScreen extends StatefulWidget {
  const TimeSelectScreen({super.key});

  @override
  State<TimeSelectScreen> createState() => _TimeSelectScreenState();
}

class _TimeSelectScreenState extends State<TimeSelectScreen> {
  Time _time = Time.fromTimeOfDay(TimeOfDay.now(), 0); // 현재 시간을 기본 값으로 설정

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime; // 시간 업데이트
    });
  }

  Future<void> sendTimeToBackend(Time time) async {
    //token 가져오기
    final loginDataProvider =
        Provider.of<LoginDataProvider>(context, listen: false);
    final token = loginDataProvider.loginData?.token;

    final url = Uri.parse(
        'http://${Global.ipAddr}:3000/api/alarms/send-push-notice'); // 백엔드 URL
    final body = json.encode({
      'hour': time.hour,
      'minute': time.minute,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'type': 'auth',
          "token": 'Bearer $token',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        // 성공적으로 전송됨
        print('Time successfully sent to backend');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => const LoginScreen()), //로그인 화면으로 이동
        );
      } else {
        // 오류 발생
        print('Failed to send time: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending time: $e');
    }
  }

  void _showTimePicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "시간 설정 방법 :",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontFamily: "IBMPlexSansKRRegular",
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "원하는 시간(분)을 선택한 후, 아래의 스크롤을 넘겨 시간을 설정해주세요.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: "IBMPlexSansKRRegular",
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 다이얼로그 닫기
                  Navigator.of(context).push(
                    showPicker(
                        context: context,
                        value: _time,
                        sunrise: const TimeOfDay(hour: 5, minute: 0), // 선택 사항
                        sunset: const TimeOfDay(hour: 18, minute: 30), // 선택 사항
                        duskSpanInMinutes: 60, // optional
                        onChange: onTimeChanged,
                        onChangeDateTime: (DateTime dateTime) {
                          // 확인 버튼 클릭 시 API 호출
                          sendTimeToBackend(_time);
                        }),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Pallete.mainBlue, // 배경색 추가
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 45), // 크기 설정
                ),
                child: const Text(
                  "네, 알겠습니다",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: "IBMPlexSansKRRegular",
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 110),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "소담이는 ",
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: "IBMPlexSansKRRegular",
                      color: Pallete.mainBlack,
                    ),
                  ),
                  TextSpan(
                    text: "매일 알림을 보내\n",
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: "IBMPlexSansKRBold",
                      color: Pallete.mainBlue,
                    ),
                  ),
                  TextSpan(
                    text: "대화 시간을 알려드릴거에요!\n",
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: "IBMPlexSansKRRegular",
                      color: Pallete.mainBlack,
                      height: 1.7,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "아래의 버튼을 눌러\n대화를 원하는 시간을\n설정해주세요.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 38,
                fontFamily: "IBMPlexSansKRRegular",
                color: Colors.black,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 50),
            TextButton(
              onPressed: _showTimePicker, // 시간 선택 다이얼로그 호출
              style: TextButton.styleFrom(
                backgroundColor: Pallete.mainBlue, // 배경색 추가
                padding: const EdgeInsets.symmetric(
                    vertical: 15, horizontal: 45), // 크기 설정
              ),
              child: const Text(
                "시간 설정하기",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontFamily: "IBMPlexSansKRRegular",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
