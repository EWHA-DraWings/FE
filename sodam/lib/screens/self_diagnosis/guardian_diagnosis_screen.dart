import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/self_diagnosis/guardian_totalscore_screen.dart';

class GuardianDiagnosisScreen extends StatefulWidget {
  const GuardianDiagnosisScreen({super.key});

  @override
  State<GuardianDiagnosisScreen> createState() =>
      _GuardianDiagnosisScreenState();
}

class _GuardianDiagnosisScreenState extends State<GuardianDiagnosisScreen> {
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

  void _onButtonPressed(int index, String value) {
    setState(() {
      _selectedOptions[index] = value;
      _scores[index] = (value == '예') ? 1 : 0;
    });
  }

  //모든 버튼이 눌려야만 총점이 계산되게 함
  bool _allOptionsSelected() {
    return !_selectedOptions.contains(null);
  }

  //총점 계산
  int _calculateTotalScore() {
    return _scores.reduce((a, b) => a + b);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.sodamGreen,
      appBar: AppBar(
        backgroundColor: Pallete.sodamGreen,
        foregroundColor: Pallete.sodamBeige, //글씨 색
        title: const Center(
          child: Text(
            "자가진단",
            style: TextStyle(
              fontSize: 24,
              fontFamily: "Gugi",
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        width: 340,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Q${index + 1}",
                            style: const TextStyle(
                              fontFamily: "IBMPlexSansKRBold",
                              fontSize: 30,
                              color: Pallete.sodamBeige,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 340,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Pallete.sodamBeige,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 25,
                            horizontal: 20,
                          ),
                          child: Text(
                            textAlign: TextAlign.center,
                            _questions[index],
                            style: const TextStyle(
                              fontFamily: "IBMPlexSansKRBold",
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            width: _selectedOptions[index] == '예' ? 100 : 90,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () => _onButtonPressed(index, '예'),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(90, 45),
                                backgroundColor: _selectedOptions[index] == '예'
                                    ? const Color.fromARGB(255, 56, 81, 56)
                                    : Pallete.sodamGray,
                                foregroundColor: _selectedOptions[index] == '예'
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : Colors.black,
                              ),
                              child: const Text(
                                '예',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Poorstory",
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            width: _selectedOptions[index] == '아니오' ? 110 : 100,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () => _onButtonPressed(index, '아니오'),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(100, 45),
                                backgroundColor:
                                    _selectedOptions[index] == '아니오'
                                        ? const Color.fromARGB(255, 56, 81, 56)
                                        : Pallete.sodamGray,
                                foregroundColor: _selectedOptions[index] ==
                                        '아니오'
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : Colors.black,
                              ),
                              child: const Text(
                                '아니오',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Poorstory",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _allOptionsSelected()
                ? ElevatedButton(
                    onPressed: () {
                      final totalScore = _calculateTotalScore();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GuardianTotalscoreScreen(score: totalScore),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: const Color.fromARGB(255, 206, 138, 178),
                    ),
                    child: const Text(
                      '제출하기',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  )
                : const Text(
                    "모든 질문에 답변해 주세요",
                    style: TextStyle(fontSize: 18),
                  ),
          ),
        ],
      ),
    );
  }
}
