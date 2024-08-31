import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/chat/bubble.dart';

class DiaryChatScreen extends StatefulWidget {
  const DiaryChatScreen({super.key});

  @override
  State<DiaryChatScreen> createState() => _DiaryChatScreenState();
}

class _DiaryChatScreenState extends State<DiaryChatScreen> {
  final scrollController = ScrollController();
  bool isInputVisible = true;

  List<Map<String, dynamic>> chatList = [
    {"text": "안녕하세요! 소담이에요.오늘 하루는 어떻게 보냈는지 이야기 해주세요.", "isUser": false},
    {"text": "오랜만에 친구랑 바다에 다녀왔어.", "isUser": true},
    {
      "text": "정말 멋진 하루를 보냈겠네요! 어떤 친구들이랑 갔는지, 바닷가는 어땠는지 좀 더 이야기해 줄 수 있을까요?",
      "isUser": false
    },
    {"text": "오늘 날씨가 어떤가요?", "isUser": true},
    {
      "text": "오늘은 맑고 화창해요. 놀러가기 딱 좋은 날씨죠.000님은 오늘 하루 어떻게 보내셨나요?",
      "isUser": false
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.sodamIvory,
      appBar: AppBar(
        backgroundColor: Pallete.sodamIvory,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color.fromARGB(255, 197, 197, 197),
              ),
              child: ClipOval(
                child: Image.asset(
                  'lib/assets/images/sodam.png', // 이미지 경로
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 15),
            const Text(
              "소담이",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "IBMPlexSansKRBold",
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 5),
          // 그림자 선
          Container(
            height: 1, // 선의 두께
            width: double.infinity, // 화면 너비 전체로 설정
            decoration: BoxDecoration(
              color: Colors.grey[300], // 선의 기본 색상 설정
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4), // 그림자 색상 및 투명도 설정
                  spreadRadius: 0.5, // 그림자 확산 정도
                  blurRadius: 3, // 그림자 흐림 정도
                  offset: const Offset(0, 1), // 그림자의 위치 (x, y)
                ),
              ],
            ),
          ),
          // 채팅
          Expanded(
            child: ListView.builder(
              //reverse: true, // 아래-> 위로 채팅이 배치됨.
              controller: scrollController,
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                return Bubble(chat: chatList[index]);
              },
            ),
          ),
          //고정 높이의 입력 필드 (예시)
          if (isInputVisible)
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: 55,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 25,
                                  ),
                                  child: Text(
                                    "무엇이든 말씀해주세요",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: "IBMPlexSansKRBold",
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // 버튼 클릭 시 동작. 나중에 음성 인식 추가해야 됨.
                                setState(() {
                                  isInputVisible = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Pallete.sodamNewDarkPink,
                                shape: const CircleBorder(), // 원형 버튼
                                padding: const EdgeInsets.all(1),
                              ),
                              child: Image.asset(
                                "lib/assets/images/voice.png",
                                width: 70,
                                height: 70,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          else
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(15),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 55,
                decoration: BoxDecoration(
                  color: Pallete.sodamNewDarkPink,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        // 버튼 클릭 시 상태 변경
                      },
                      icon: Image.asset(
                        "lib/assets/images/trash.png",
                        width: 70,
                        height: 70,
                      ),
                      iconSize: 70, // 아이콘 크기
                    ),
                    const SizedBox(width: 10),
                    //시간.
                    IconButton(
                      onPressed: () {
                        // 버튼 클릭 시 상태 변경
                        setState(() {
                          isInputVisible = true;
                        });
                      },
                      icon: Image.asset(
                        "lib/assets/images/arrow.png",
                        width: 70,
                        height: 70,
                      ),
                      iconSize: 70, // 아이콘 크기
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
