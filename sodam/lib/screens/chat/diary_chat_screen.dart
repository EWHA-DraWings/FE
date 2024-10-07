import 'dart:convert'; // For JSON encoding/decoding
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sodam/models/websocket_provider.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/chat/bubble.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:permission_handler/permission_handler.dart';

class DiaryChatScreen extends StatefulWidget {
  final String gptText; //시작 메세지 받아옴
  const DiaryChatScreen({super.key, required this.gptText});

  @override
  State<DiaryChatScreen> createState() => _DiaryChatScreenState();
}

class _DiaryChatScreenState extends State<DiaryChatScreen> {
  final scrollController = ScrollController();
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder(); // 음성 녹음
  late final RecorderController _recorderController; // 음성 파형 보여주기 위한 컨트롤러

  bool isInputVisible = true;
  bool isRecording = false; // 녹음 상태
  List<Map<String, dynamic>> chatList = []; //채팅 메세지 저장
  List<double> waveData = []; //음성 파형 데이터 저장
  late final List<int> audioBuffer; // 음성 데이터를 저장할 버퍼

  @override
  //gpt에게 온 시작메세지 호출 및 녹음기 초기화
  void initState() {
    super.initState();

    _requestPermissions(); //녹음 사용 권한 요청
    chatList.add({"text": widget.gptText, "isUser": false}); //gpt 초기 메세지 추가
    _initRecorder(); //녹음기 초기화
    _recorderController = RecorderController(); // Initialize RecorderController
    audioBuffer = []; // Initialize audio buffer

    // Listen for WebSocket messages
    final webSocketProvider =
        Provider.of<WebSocketProvider>(context, listen: false);

    webSocketProvider.addListener(() {
      // Check for incoming messages and update chat
      // This function will be called whenever notifyListeners() is called
      final incomingMessage = webSocketProvider.lastReceivedMessage;

      if (incomingMessage != null) {
        // Parse the incoming message
        final responseData = jsonDecode(incomingMessage);

        // Check the type of message
        if (responseData['type'] == 'response') {
          setState(() {
            // Add user text and chatbot's response to the chat list
            chatList.add({"text": responseData['userText'], "isUser": true});
            chatList.add({"text": responseData['gptText'], "isUser": false});
          });
        } else {
          print("error:response 처리 실패");
        }
      }
    });
  }

  //녹음기 사용 권한 요청
  Future<void> _requestPermissions() async {
    // Check the current status of microphone permission
    final status = await Permission.microphone.status; // 마이크 권한 상태 확인
    if (!status.isGranted) {
      // Request permission if not granted
      final result = await Permission.microphone.request(); // 권한 요청

      if (result.isDenied) {
        // Handle the case when permission is denied
        // You can show a dialog or a Snackbar here
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text("Microphone permission is required to record audio.")),
        );
      }
    }
  }

  // 녹음기 초기화
  Future<void> _initRecorder() async {
    await _recorder.openRecorder();
  }

  //녹음 시작
  Future<void> startRecording() async {
    final status = await Permission.microphone.status;
    waveData.clear(); // Clear previous wave data
    if (status.isGranted) {
      try {
        await _recorder.startRecorder(codec: Codec.aacADTS); //녹음 시작
        setState(() {
          isRecording = true;
        });

        // Update wave data periodically while recording
        _recorder.onProgress!.listen((event) {
          setState(() {
            waveData.add(event.decibels!);
          });
        });
      } catch (e) {
        // Handle error (e.g., log or show an error message)
        print("Failed to start recording.: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to start recording:")),
        );
      }
    } else {
      // If the microphone permission is not granted, you may want to prompt the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text("Microphone permission is required to start recording.")),
      );
    }
  }

  // 녹음 중지후 녹음 데이터를 바이너리로 읽어 서버에 전송
  Future<void> stopRecording() async {
    final recordingResult = await _recorder.stopRecorder();
    setState(() {
      isRecording = false;
    });

    // 바이너리 데이터를 직접 메모리에서 서버로 전송
    final audioBytes =
        await File(recordingResult!).readAsBytes(); // 파일에서 바이너리 데이터 읽기
    final webSocketProvider =
        Provider.of<WebSocketProvider>(context, listen: false);
    // 웹소켓을 통해 바이너리 데이터 전송
    webSocketProvider.sendMessage(audioBytes); // audioBytes를 직접 전송
  }

  @override
  void dispose() {
    //녹음기, 녹음기 컨트롤러 정리
    _recorder.closeRecorder();
    _recorderController.dispose();
    super.dispose();
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
      body: Column(
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
                    child: GestureDetector(
                      onTap: () {
                        if (isRecording) {
                          stopRecording(); // 녹음 중이면 중지
                        } else {
                          startRecording(); // 녹음 시작
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor:
                                isRecording ? Colors.red : Colors.blue,
                          ),
                          Image.asset(
                            "lib/assets/images/voice.png",
                            width: 40,
                            height: 40,
                          ),
                          if (isRecording)
                            AudioWaveforms(
                              size:
                                  const Size(double.infinity, 100), // 파형 크기 설정
                              recorderController:
                                  _recorderController, // Use RecorderController
                              enableGesture: false,
                              waveStyle: const WaveStyle(
                                showMiddleLine: false,
                                extendWaveform: true,
                                waveColor: Colors.white,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
