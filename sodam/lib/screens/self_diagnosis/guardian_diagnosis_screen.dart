import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sodam/global.dart';
import 'package:sodam/models/login_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/self_diagnosis/guardian_totalscore_screen.dart';
import 'package:sodam/widgets/choice_button.dart';
import 'package:sodam/widgets/title_widget.dart';
import 'package:http/http.dart' as http;

class GuardianDiagnosisScreen extends StatefulWidget {
  const GuardianDiagnosisScreen({super.key});

  @override
  State<GuardianDiagnosisScreen> createState() =>
      _GuardianDiagnosisScreenState();
}

class _GuardianDiagnosisScreenState extends State<GuardianDiagnosisScreen> {
  int index = 0;

  Future<void> saveResults(int totalScore) async {
    final loginDataProvider =
        Provider.of<LoginDataProvider>(context, listen: false);
    final token = loginDataProvider.loginData?.token;

    final url = Uri.parse('http://${Global.ipAddr}:3000/api/assessments');

    //전송할 데이터
    final Map<String, dynamic> requestBody = {
      "guardianId": loginDataProvider.loginData!.id,
      "questionnaireType": "KDSQ",
      "score": totalScore,
      "date": DateTime.now().toString(),
    };

    String jsonRequest = jsonEncode(requestBody);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonRequest,
    );

    if (response.statusCode == 201) {
      //저장 완료 -> 결과 화면으로 이동
      final jsonData = json.decode(response.body);
      final elderlyName = jsonData['data']['name'];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GuardianTotalscoreScreen(
            score: totalScore,
            name: elderlyName,
          ),
        ),
      );
    } else if (response.statusCode == 400) {
      print(response);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('잘못된 요청으로 결과가 저장되지 않았어요. 다시 시도해주세요.')),
      );
    } else {
      //500
      print(response.statusCode);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('서버 오류로 결과가 저장되지 않았어요. 다시 시도해주세요.')),
      );
    }
  }

  final List<String> _questions = [
    "오늘이 몇 월이고, 무슨 요일인지를 잘 모른다.",
    "자신이 놔둔 물건을 찾지 못한다.",
    "같은 질문을 반복해서 한다.",
    "약속을 하고서 잊어버린다.",
    "물건을 가지러 갔다가 잊어버리고 그냥 온다.",
    "물건이나 사람의 이름을 대기가 힘들어 머뭇거린다.",
    "대화 중 내용이 이해되지 않아 반복해서 물어본다.",
    "길을 잃거나 헤맨 적이 있다.",
    "예전에 비해서 계산 능력이 떨어졌다.(물건 값이나 거스름돈 계산을 못한다)",
    "예전에 비해 성격이 변했다.",
    "이전에 잘 다루던 기구의 사용이 서툴러졌다.(세탁기, 전기밥솥, 경운기등)",
    "예전에 비해 방이나 집안의 정리정돈을 하지 못한다.",
    "상황에 맞게 스스로 옷을 선택하여 입지 못한다.",
    "혼자 대중교통 수단을 이용하여 목적지에 가기 힘들다.(신체적인 문제로 인한 것은 제외)",
    "내복이나 옷이 더러워져도 갈아입지 않으려고 한다."
  ];
  final List<String?> _selectedOptions = List<String?>.filled(15, null);
  final List<int> _scores = List<int>.filled(15, 0);

  void _onButtonPressed(int idx, int value) {
    setState(() {
      _selectedOptions[idx] = value.toString();
      _scores[index] = value;
    });
  }

  //다음 버튼
  void _nextButtonPressed() {
    setState(() {
      if (index < 14) {
        index++;
      } else {
        //결과 화면으로 전환
        final totalScore = _calculateTotalScore();
        saveResults(totalScore);
      }
    });
  }

  //총점 계산
  int _calculateTotalScore() {
    return _scores.reduce((a, b) => a + b);
  }

  //kdsq
  @override
  Widget build(BuildContext context) {
    const btnInterval = 28.0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, //글씨 색
      ),
      body: Column(
        children: [
          const TitleWidget(
            backgroundColor: Pallete.mainBlue,
            textColor: Colors.white,
            text: '자가진단',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 50,
              horizontal: 30,
            ),
            child: Text(
              _questions[index],
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontFamily: "IBMPlexSansKRRegular",
                fontWeight: FontWeight.w600,
                fontSize: 22,
                color: Color(0xFF191D63),
              ),
            ),
          ),
          ChoiceButton(
            text: '자주',
            val: 2,
            onPressed: () => _onButtonPressed(index, 2),
            selectedOptions: _selectedOptions,
            index: index,
          ),
          const SizedBox(
            height: btnInterval,
          ),
          ChoiceButton(
            text: '가끔',
            val: 1,
            onPressed: () => _onButtonPressed(index, 1),
            selectedOptions: _selectedOptions,
            index: index,
          ),
          const SizedBox(
            height: btnInterval,
          ),
          ChoiceButton(
            text: '아니다',
            val: 0,
            onPressed: () => _onButtonPressed(index, 0),
            selectedOptions: _selectedOptions,
            index: index,
          ),
          Expanded(child: Container()), // 상단의 공간을 채우기 위해 Expanded를 사용
          LinearPercentIndicator(
            width: MediaQuery.of(context).size.width * 0.83,
            animation: true,
            animationDuration: 100,
            lineHeight: 20.0,
            trailing: Text(
              "${index + 1}/15",
              style: const TextStyle(
                fontFamily: 'IBMPlexSansKRRegular',
                fontSize: 15,
              ),
            ),
            percent: (index + 1) / 15,
            backgroundColor: Pallete.mainGray,
            progressColor: const Color(0xFFD768C5),
            barRadius: const Radius.circular(10),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: ElevatedButton(
              onPressed:
                  _selectedOptions[index] != null ? _nextButtonPressed : null,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                  MediaQuery.of(context).size.width * 0.9,
                  60,
                ),
                backgroundColor: Pallete.mainBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                '다음',
                style: TextStyle(
                  fontFamily: 'IBMPlexSansKRRegular',
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
