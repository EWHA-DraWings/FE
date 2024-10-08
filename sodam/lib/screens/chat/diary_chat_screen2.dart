import 'dart:convert';
import 'dart:io'; // Add this import for file handling
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart'; // Import the package
import 'package:path_provider/path_provider.dart'; // For getting the temporary directory
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

  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  String? _recordingPath; // Declare a variable to hold the recording path

  @override
  void initState() {
    super.initState();
    _startConversation();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    try {
      await _recorder.openRecorder();
    } catch (e) {
      print("Error opening recorder: $e");
    }
  }

  Future<void> _startConversation() async {
    print("startConversation 호출됨");
    final loginDataProvider =
        Provider.of<LoginDataProvider>(context, listen: false);
    final token = loginDataProvider.loginData?.token;
    print("token: $token");

    final webSocketProvider =
        Provider.of<WebSocketProvider2>(context, listen: false);
    webSocketProvider.connect('ws://${Global.ipAddr}:3000/ws/diary');
    print("연결2");

    webSocketProvider.listen();

    webSocketProvider.addListener(() {
      print("리스너연결");
      final incomingMessage = webSocketProvider.lastReceivedMessage;
      print("응답 수신됨 : $incomingMessage");
      if (incomingMessage != null) {
        final responseData = jsonDecode(incomingMessage);
        if (responseData['type'] == 'response') {
          setState(() {
            if (responseData['userText'] == "...") {
              chatList.add({"text": responseData['gptText'], "isUser": false});
            } else {
              chatList.add({"text": responseData['userText'], "isUser": true});
              chatList.add({"text": responseData['gptText'], "isUser": false});
            }
            print("Updated chatList: $chatList");
          });
        } else {
          print("error: response 처리 실패");
        }
      }
    });
    final requestMessage = jsonEncode({
      "type": "startConversation",
      "token": token,
      "sessionId": null,
    });

    webSocketProvider.sendMessage(requestMessage);
    print("요청 메시지 전송됨 $requestMessage");
  }

  Future<void> sendMessage(String audioFilePath) async {
    final webSocketProvider =
        Provider.of<WebSocketProvider2>(context, listen: false);
    if (!webSocketProvider.checkConnection()) {
      print("WebSocket is not connected!");
      return;
    }
    print("audiobyte 보내기:");

    final audioBytes = await File(audioFilePath).readAsBytes();
    final base64Audio = base64Encode(audioBytes);

    // Add user message to the chat list
    // setState(() {
    //   chatList.add({"text": "Audio message sent", "isUser": true}); // 사용자 메세지
    // });
    print("message 사용자가 전송 :");

    // Create the message data in the desired format
    final messageData = jsonEncode({
      base64Audio, // Base64 encoded audio
    });
    webSocketProvider.sendMessage(messageData);
  }

  Future<void> startRecording() async {
    try {
      _recordingPath =
          await getTemporaryDirectory().then((dir) => '${dir.path}/audio.wav');
      await _recorder.startRecorder(toFile: _recordingPath);
      setState(() {
        _isRecording = true;
      });
    } catch (e) {
      print("Error starting recorder: $e");
    }
  }

  Future<String?> stopRecording() async {
    try {
      await _recorder.stopRecorder();
      setState(() {
        _isRecording = false;
      });
      return _recordingPath;
    } catch (e) {
      print("Error stopping recorder: $e");
      return null;
    }
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
                  child: ElevatedButton(
                    onPressed: () {
                      print("버튼이 클릭됨");
                      if (_isRecording) {
                        stopRecording().then((path) {
                          if (path != null) {
                            sendMessage(path); // Send the recorded audio
                          }
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isRecording
                          ? const Color.fromARGB(255, 40, 0, 46)
                          : Pallete.mainBlue,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(1),
                    ),
                    child: Image.asset(
                      "lib/assets/images/voice.png",
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _recorder.stopRecorder(); // Close the audio session when disposing
    super.dispose();
  }
}
