import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/self_diagnosis/user_totalscore_screen.dart';
import 'package:sodam/widgets/choice_button.dart';
import 'package:sodam/widgets/title_widget.dart';

class UserDiagnosisScreen extends StatefulWidget {
  const UserDiagnosisScreen({super.key});

  @override
  State<UserDiagnosisScreen> createState() => _UserDiagnosisScreenState();
}

class _UserDiagnosisScreenState extends State<UserDiagnosisScreen> {
  int index = 0;

  final FlutterTts flutterTts = FlutterTts();

  //tts 기본 설정
  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("ko-KR");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  final List<String> _questions = [
    "잠시 후 무엇을 해야겠다고 마음을 먹고 나서 잊어버리는 경우가 있습니까?",
    "전에 가 본 적이 있는 장소인데, 기억이 안 나는 경우가 있습니까?",
    "조금 있다가 해야 할 일이 있는데, 그 일 혹은 그와 관련된 물건을 직접 보면서도 잊어버리는 경우가 있습니까?",
    "몇 분 전에 들었던 이야기를 잊어버리는 경우가 있습니까?",
    "달력이나 수첩에 적어놓지 않거나 누가 말해 주지 않으면, 약속을 잊어버리는 경우가 있습니까?",
    "TV나 라디오에서 장면이 바뀌면, 출연자를 잘 알아보지 못하는 경우가 있습니까?",
    "사려고 했던 물건인데(비누 등), 시장에 가서 그 물건을 보고도 잊어버리고 안 사는 경우가 있습니까?",
    "며칠 전에 있었던 일이 잘 기억나지 않는 경우가 있습니까?",
    "예전에 말한 적이 있는데, 똑같은 사람에게 같은 말을 되풀이해서 하는 경우가 있습니까?",
    "나가기 전에는 그 물건을 갖고 나가야겠다고 생각을 해놓고, 잠시 후에는 그 물건을 보면서도 방에 그냥 두고 나오는 경우가 있습니까?",
    "안경이나 신문 같은 물건을 어디에 두었는지 잊어버리는 경우가 있습니까?",
    "어떤 물건이나 말을 전해달라고 부탁을 받았는데, 상대방을 보면서도 잊어버려 전해주지 못하는 경우가 있습니까?",
    "예전에 본 적이 있는 장면이나 물건인데, 지금 다시 보면서도 예전에 봤었다는 사실을 기억하지 못하는 경우가 있습니까?",
    "친구나 친척에게 전화를 했지만 연락이 닿지 않았을 때, 다시 전화 거는 것을 잊어버리는 경우가 있습니까?",
    "어제 텔레비전에서 무엇을 봤는지 잊어버리는 경우가 있습니까?",
    "몇 분 전에는 해야 할 말을 생각해 놓고서, 상대방에게 그 말을 하는 것을 잊어버리는 경우가 있습니까?",
  ];
  final List<String?> _selectedOptions = List<String?>.filled(16, null);
  final List<int> _scores = List<int>.filled(16, 0);

  //답 고름
  void _onButtonPressed(int idx, int value) {
    setState(() {
      _selectedOptions[idx] = value.toString();
      _scores[idx] = value;
    });
  }

  //다음 버튼
  void _nextButtonPressed() {
    setState(() {
      if (index < 15) {
        index++;
      } else {
        //결과 화면으로 전환
        final totalScore = _calculateTotalScore();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserTotalscoreScreen(score: totalScore),
          ),
        );
      }
    });
  }

  //총점 계산
  int _calculateTotalScore() {
    return _scores.reduce((a, b) => a + b);
  }

  //prmq
  @override
  Widget build(BuildContext context) {
    const btnInterval = 13.0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, //글씨 색
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            const TitleWidget(
              backgroundColor: Pallete.mainBlue,
              textColor: Colors.white,
              text: '자가진단',
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: index != 2
                    ? () => _speak(
                          _questions[index],
                        )
                    : () => _speak(
                          '${_questions[index]} 예시. 약 봉지를 보고서도 약 먹는 일을 잊어버린다든지, 가스 불 위의 주전자를 보면서도 가스 불 끄는 것을 잊어버리는 경우',
                        ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 30,
                  ),
                  child: index != 2
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Text(
                            '📢 ${_questions[index]}',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontFamily: "IBMPlexSansKRRegular",
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: Color(0xFF191D63),
                            ),
                          ),
                        )
                      : Text.rich(
                          TextSpan(
                            text: '📢 ${_questions[index]}',
                            style: const TextStyle(
                              fontFamily: "IBMPlexSansKRRegular",
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Color(0xFF191D63),
                            ),
                            children: const <TextSpan>[
                              TextSpan(
                                text:
                                    '\n\n예시) 약 봉지를 보고서도 약 먹는 일을 잊어버린다든지, 가스 불 위의 주전자를 보면서도 가스 불 끄는 것을 잊어버리는 경우',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0XFF060710),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
            ChoiceButton(
              text: '전혀 아님',
              val: 1,
              onPressed: () => {
                _speak(
                  '전혀 아님',
                ),
                _onButtonPressed(index, 1),
              },
              selectedOptions: _selectedOptions,
              index: index,
            ),
            const SizedBox(
              height: btnInterval,
            ),
            ChoiceButton(
              text: '아주 가끔',
              val: 2,
              onPressed: () => {
                _speak(
                  '아주 가끔',
                ),
                _onButtonPressed(index, 2),
              },
              selectedOptions: _selectedOptions,
              index: index,
            ),
            const SizedBox(
              height: btnInterval,
            ),
            ChoiceButton(
              text: '가끔',
              val: 3,
              onPressed: () => {
                _speak(
                  '가끔',
                ),
                _onButtonPressed(index, 3),
              },
              selectedOptions: _selectedOptions,
              index: index,
            ),
            const SizedBox(
              height: btnInterval,
            ),
            ChoiceButton(
              text: '자주',
              val: 4,
              onPressed: () => {
                _speak(
                  '자주',
                ),
                _onButtonPressed(index, 4),
              },
              selectedOptions: _selectedOptions,
              index: index,
            ),
            const SizedBox(
              height: btnInterval,
            ),
            ChoiceButton(
              text: '매우 자주',
              val: 5,
              onPressed: () => {
                _speak(
                  '매우 자주',
                ),
                _onButtonPressed(index, 5),
              },
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
                "${index + 1}/16",
                style: const TextStyle(
                  fontFamily: 'IBMPlexSansKRRegular',
                  fontSize: 15,
                ),
              ),
              percent: (index + 1) / 16,
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
      ),
    );
  }
}
