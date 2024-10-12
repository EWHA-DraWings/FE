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
import 'package:permission_handler/permission_handler.dart'; //마이크 권한 허용

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
  // Store the listener function
  late void Function() _webSocketListener;
  late WebSocketProvider2 webSocketProvider;
  @override
  void initState() {
    super.initState();
    webSocketProvider = Provider.of<WebSocketProvider2>(context, listen: false);
    _startConversation();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    var status = await Permission.microphone.status; //마이크 권한 췍
    if (!status.isGranted) {
      status = await Permission.microphone.request();
    }

    if (status.isGranted) {
      try {
        await _recorder.openRecorder();
      } catch (e) {
        print("Error opening recorder: $e");
      }
    } else {
      print("Microphone permission denied.");
    }
  }

  Future<void> _startConversation() async {
    print("startConversation 호출됨");
    final loginDataProvider =
        Provider.of<LoginDataProvider>(context, listen: false);
    final token = loginDataProvider.loginData?.token;
    print("token: $token");

    webSocketProvider.connect('ws://${Global.ipAddr}:3000/ws/diary');
    print("연결2");

    webSocketProvider.listen();

    _webSocketListener = () {
      print("리스너 연결");
      final incomingMessage = webSocketProvider.lastReceivedMessage;
      print("응답 수신됨 : $incomingMessage");
      if (incomingMessage != null) {
        final responseData = jsonDecode(incomingMessage);
        if (responseData['type'] == 'response') {
          if (mounted) {
            setState(() {
              if (responseData.containsKey('gptText')) {
                chatList
                    .add({"text": responseData['gptText'], "isUser": false});
              }
              if (responseData.containsKey('userText') &&
                  responseData['userText'] != "...") {
                chatList
                    .add({"text": responseData['userText'], "isUser": true});
              }

              print("Updated chatList: $chatList");
              _scrollToBottom();
            });
          }
        } else {
          print("error: response 처리 실패");
        }
      }
    };
    webSocketProvider.addListener(_webSocketListener);

    final requestMessage = jsonEncode({
      "type": "startConversation",
      "token": token,
      "sessionId": null,
    });

    webSocketProvider.sendStartMessage(requestMessage);
    print("요청 메시지 전송됨 $requestMessage");
  }

  Future<void> sendMessage(String audioFilePath) async {
    if (!webSocketProvider.checkConnection()) {
      print("WebSocket is not connected!");
      return;
    }
    print("audiobyte 보내기:");

    final audioBytes = await File(audioFilePath).readAsBytes();

    print("message 사용자가 전송 :");

    webSocketProvider.sendMessageAsBinary(audioBytes);
  }

  Future<void> startRecording() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      status = await Permission.microphone.request();
    }

    if (status.isGranted) {
      try {
        _recordingPath = await getTemporaryDirectory()
            .then((dir) => '${dir.path}/audio.wav');
        await _recorder.startRecorder(toFile: _recordingPath);
        setState(() {
          _isRecording = true;
        });
      } catch (e) {
        print("Error starting recorder: $e");
      }
    } else {
      print("Microphone permission denied.");
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

  //가장 최근 보내진 채팅으로 스크롤되게
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
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
                      } else {
                        startRecording();
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
    webSocketProvider.removeListener(_webSocketListener); // 리스너 제거
    _recorder.stopRecorder(); // Close the audio session when disposing
    super.dispose();
  }
}
