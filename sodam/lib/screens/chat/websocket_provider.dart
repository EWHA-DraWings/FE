import 'dart:convert';
import 'dart:async';
import 'dart:typed_data'; //Uint8List 처리
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:audioplayers/audioplayers.dart'; //오디오 재생 기능
import 'package:path_provider/path_provider.dart'; //파일 시스템에서 디렉터리 경로를 찾기 위해 필요
import 'dart:io'; // File 클래스 사용

class WebSocketProvider with ChangeNotifier {
  WebSocketChannel? _channel;
  String? lastReceivedMessage;
  bool isConnected = false; //웹소켓 연결 확인
  int? expectedAudioSize; //음성 데이터 크기
  Uint8List? _receivedAudioData; // 누적된 음성 데이터를 저장
  final AudioPlayer _audioPlayer = AudioPlayer(); // AudioPlayer 인스턴스 생성

  // WebSocket 연결
  void connect(String url) {
    print("연결");
    isConnected = true;
    _channel = WebSocketChannel.connect(Uri.parse(url));
  }
  //리스너 설정

  // Listen for incoming messages
  void listen() {
    print("listening...");
    if (_channel != null) {
      _channel!.stream.listen((message) {
        if (message is Uint8List) {
          // Handle binary message (audio)
          print("Received Uint8List");
          _playAudio(message); // Method to play audio
        } else if (message is String) {
          // Handle string message
          final Map<String, dynamic> jsonData = jsonDecode(message);
          //음성 데이터 크기 받아옴
          if (jsonData.containsKey('audiosize')) {
            expectedAudioSize = jsonData['audioSize'];
            _receivedAudioData = Uint8List(0); // 데이터 누적을 위한 초기화
          }
          lastReceivedMessage = message;
          notifyListeners(); // Notify listeners that a new message has been received
        } else {
          print("Unexpected message type: ${message.runtimeType}");
          lastReceivedMessage =
              "Unexpected message format"; // Handle unexpected message format
        }
      }, onError: (error) {
        isConnected = false;
        print("WebSocket error: $error");
        // Handle errors
      }, onDone: () {
        isConnected = false;
        print("WebSocket connection closed");
        // Handle connection closed
      });
    }
  }

  // 음성 데이터 누적
  void _accumulateAudioData(Uint8List chunk) {
    if (expectedAudioSize != null && _receivedAudioData != null) {
      _receivedAudioData = Uint8List.fromList(
        _receivedAudioData! + chunk,
      );

      print("현재 누적된 데이터 크기: ${_receivedAudioData!.length}");

      // 모든 데이터를 받았을 경우
      if (_receivedAudioData!.length >= expectedAudioSize!) {
        print("음성 데이터 모두 수신 완료. 재생 시작.");
        _playAudio(_receivedAudioData!); // 음성 재생
        _receivedAudioData = null; // 재생 후 초기화
        expectedAudioSize = null; // 다음 파일을 위해 초기화
      }
    }
  }

  // 음성 재생
  Future<void> _playAudio(Uint8List audioData) async {
    try {
      // 임시 파일로 저장하여 재생
      //getTemporaryDirectory를 통해 임시 파일의 경로를 얻고, File 객체를 생성하여 데이터를 씁니다.
      String tempPath = (await getTemporaryDirectory()).path;
      File tempFile = File(
          '$tempPath/temp_audio_${DateTime.now().millisecondsSinceEpoch}.mp3'); //음성마다 파일 고유하게 생성되게
      await tempFile.writeAsBytes(audioData);
      // Source 객체로 변환하여 재생
      await _audioPlayer
          .play(DeviceFileSource(tempFile.path)); // Source로 변환 후 재생
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  bool checkConnection() {
    return isConnected;
  }

  // 메시지 전송
  void sendStartMessage(String message) {
    print("Sending message...");
    if (_channel != null) {
      _channel!.sink.add(message);
      print("메시지 전송됨: $message");
    } else {
      print("WebSocket이 연결되어 있지 않습니다.");
    }
  }

  // 메시지 전송 (바이너리)
  void sendMessageAsBinary(Uint8List messageBytes) {
    print("Sending binary message...");
    if (_channel != null) {
      _channel!.sink.add(messageBytes);
      print("Binary 메시지 전송됨");
    } else {
      print("WebSocket이 연결되어 있지 않습니다.");
    }
  }

  // WebSocket 연결 종료
  void disconnect() {
    isConnected = false;
    _channel?.sink.close();
    notifyListeners();
  }

  // 마지막 수신된 메시지를 가져오는 getter
  String? get getLastReceivedMessage => lastReceivedMessage;

  // ChangeNotifier에서 해제
  @override
  void dispose() {
    disconnect();
    super.dispose();
  }
}
