import 'dart:convert'; // For JSON encoding/decoding
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sodam/global.dart';
import 'package:sodam/models/login_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/chat/bubble.dart';
import 'package:sodam/screens/chat/websocket_provider2.dart';

class DiaryChatScreen2 extends StatefulWidget {
  const DiaryChatScreen2({super.key});

  @override
  State<DiaryChatScreen2> createState() => _DiaryChatScreen2State();
}

class _DiaryChatScreen2State extends State<DiaryChatScreen2> {
  final scrollController = ScrollController();
  bool isInputVisible = true;
  List<Map<String, dynamic>> chatList = [];

  TextEditingController inputController =
      TextEditingController(); // For user input

  @override
  void initState() {
    super.initState();
    _startConversation();
  }

  Future<void> _startConversation() async {
    print("startConversation 호출됨");
    //토큰 값 가져오기
    final loginDataProvider =
        Provider.of<LoginDataProvider>(context, listen: false);
    final token = loginDataProvider.loginData?.token;
    print("token: $token");

    final webSocketProvider =
        Provider.of<WebSocketProvider2>(context, listen: false);

    //WebSocket 연결
    webSocketProvider.connect('ws://${Global.ipAddr}:3000/ws/diary');
    // Start listening for incoming messages
    webSocketProvider.listen();

    final requestMessage = jsonEncode({
      "type": "startConversation",
      "token": token, // Assuming you have a way to get the token
      "sessionId": null,
    });

    // Send the request
    webSocketProvider.sendMessage(requestMessage);
    print("요청 메시지 전송됨");

    // Listen for incoming messages
    webSocketProvider.addListener(() {
      final incomingMessage = webSocketProvider.lastReceivedMessage;
      print("응답 수신됨 : $incomingMessage");
      if (incomingMessage != null) {
        // Parse the incoming message
        final responseData = jsonDecode(incomingMessage);

        // Check the type of message
        if (responseData['type'] == 'response') {
          setState(() {
            if (responseData['userText'] == "...") {
              // userText가 "..."일 경우 gptText만 추가
              chatList.add({"text": responseData['gptText'], "isUser": false});
            } else {
              // userText와 gptText 모두 추가
              chatList.add({"text": responseData['userText'], "isUser": true});
              chatList.add({"text": responseData['gptText'], "isUser": false});
            }
            print("Updated chatList: $chatList"); // Check updated chatList
          });
        } else {
          print("error: response 처리 실패");
        }
      }
    });
  }

  Future<void> sendMessage(String message) async {
    final webSocketProvider =
        Provider.of<WebSocketProvider2>(context, listen: false);
    if (!webSocketProvider.checkConnection()) {
      print("WebSocket is not connected!");
      return; // 연결이 안 된 경우 메시지 전송을 중단합니다.
    }
    setState(() {
      chatList.add({"text": message, "isUser": true}); // 사용자 메세지
    });

    // Send the user's message
    final messageData = jsonEncode({"type": "userMessage", "text": message});
    webSocketProvider
        .sendMessage(messageData); // Implement this in your WebSocketProvider
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.mainWhite,
      appBar: AppBar(
        backgroundColor: Pallete.mainWhite,
        scrolledUnderElevation: 0,
        title: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color(0xFFCDDEF8),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'lib/assets/images/sodam.png',
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
            const SizedBox(height: 5),
          ],
        ),
      ),
      body: Consumer<WebSocketProvider2>(
        builder: (context, webSocketProvider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: chatList.length,
                  itemBuilder: (context, index) {
                    return Bubble(chat: chatList[index]);
                  },
                ),
              ),
              if (isInputVisible)
                Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: inputController,
                          decoration: InputDecoration(
                            hintText: '무엇이든 말씀해주세요',
                            hintStyle: const TextStyle(
                              fontSize: 17,
                              fontFamily: "IBMPlexSansKRBold",
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Pallete.mainGray,
                            contentPadding: const EdgeInsets.only(left: 25),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (inputController.text.isNotEmpty) {
                            sendMessage(inputController.text); // Send message
                            inputController.clear(); // Clear input
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Pallete.mainBlue,
                          shape: const CircleBorder(),
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
                ),
            ],
          );
        },
      ),
    );
  }
}
