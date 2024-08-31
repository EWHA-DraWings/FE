import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/self_diagnosis/guardian_totalscore_screen.dart';
import 'package:sodam/screens/self_diagnosis/user_totalscore_screen.dart';

class UserDiagnosisScreen extends StatefulWidget {
  const UserDiagnosisScreen({super.key});

  @override
  State<UserDiagnosisScreen> createState() => _UserDiagnosisScreenState();
}

class _UserDiagnosisScreenState extends State<UserDiagnosisScreen> {
  final List<String> _questions = [
    "잠시 후 무엇을 해야겠다고 마음을 먹고 나서 잊어버리는 경우가 있습니까?",
    "전에 가 본적이 있는 장소인데, 기억이 안 나는 경우가 있습니까?",
    "조금 있다가 해야 할 일이 있는데, 그 일 혹은 그와 관련된 물건을 직접 보면서도 잊어버리는 경우가 있습니까?(예를 들면, 약 봉지를 보고서도 약 먹는 일을 잊어버린다든지, 가스 불 위의 주전자를 보면서도 가스 불 끄는 것을 잊어버리는 경우)",
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

  void _onButtonPressed(int index, int value) {
    setState(() {
      _selectedOptions[index] = value.toString();
      _scores[index] = value;
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
      backgroundColor: Pallete.sodamIvory,
      appBar: AppBar(
        backgroundColor: Pallete.sodamIvory,
        foregroundColor: Colors.black, //글씨 색
        title: const Text(
          "PRMQ 자가진단",
          style: TextStyle(
            fontSize: 24,
            fontFamily: "Gugi",
          ),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Text(
              '아래의 질문들은 누구나 가끔씩 겪을 수 있는 \n소소한 기억 문제에 관한 것들이에요. \n이러한 일들을 얼마나 자주 경험하시나요?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "IBMPlexSansKRBold",
                fontSize: 20,
                color: Pallete.sodamBrown,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: ListView.builder(
                itemCount: 16,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Q${index + 1}",
                              style: const TextStyle(
                                fontFamily: "IBMPlexSansKRBold",
                                fontSize: 30,
                                color: Pallete.sodamYellow,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Pallete.sodamYellow.withOpacity(0.7),
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
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            width: 300,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () => _onButtonPressed(index, 1),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(90, 45),
                                backgroundColor: _selectedOptions[index] == '1'
                                    ? Pallete.sodamNewGreen
                                    : Pallete.sodamGray,
                                foregroundColor: _selectedOptions[index] == '1'
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : Colors.black,
                              ),
                              child: const Text(
                                '전혀 아님',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: "Poorstory",
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            width: 300,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () => _onButtonPressed(index, 2),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(100, 45),
                                backgroundColor: _selectedOptions[index] == '2'
                                    ? Pallete.sodamNewGreen
                                    : Pallete.sodamGray,
                                foregroundColor: _selectedOptions[index] == '2'
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : Colors.black,
                              ),
                              child: const Text(
                                '아주 가끔',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: "Poorstory",
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            width: 300,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () => _onButtonPressed(index, 3),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(90, 45),
                                backgroundColor: _selectedOptions[index] == '3'
                                    ? Pallete.sodamNewGreen
                                    : Pallete.sodamGray,
                                foregroundColor: _selectedOptions[index] == '3'
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : Colors.black,
                              ),
                              child: const Text(
                                '가끔',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: "Poorstory",
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            width: 300,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () => _onButtonPressed(index, 4),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(100, 45),
                                backgroundColor: _selectedOptions[index] == '4'
                                    ? Pallete.sodamNewGreen
                                    : Pallete.sodamGray,
                                foregroundColor: _selectedOptions[index] == '4'
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : Colors.black,
                              ),
                              child: const Text(
                                '자주',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: "Poorstory",
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            width: 300,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () => _onButtonPressed(index, 5),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(100, 45),
                                backgroundColor: _selectedOptions[index] == '5'
                                    ? Pallete.sodamNewGreen
                                    : Pallete.sodamGray,
                                foregroundColor: _selectedOptions[index] == '5'
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : Colors.black,
                              ),
                              child: const Text(
                                '매우 자주',
                                style: TextStyle(
                                  fontSize: 25,
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
                              UserTotalscoreScreen(score: totalScore),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Pallete.sodamNewDarkPink,
                    ),
                    child: const Text(
                      '제출하기',
                      style: TextStyle(
                        fontFamily: 'IBMPlexSansKRRegular',
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  )
                : ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Pallete.sodamOrange,
                    ),
                    child: const Text(
                      "모든 질문에 답변해 주세요",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
