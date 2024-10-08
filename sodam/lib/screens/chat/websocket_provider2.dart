import 'dart:convert';
import 'dart:async';
import 'dart:typed_data'; //Uint8List 처리
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:audioplayers/audioplayers.dart'; //오디오 재생 기능
import 'package:path_provider/path_provider.dart'; //파일 시스템에서 디렉터리 경로를 찾기 위해 필요
import 'dart:io'; // File 클래스 사용

class WebSocketProvider2 with ChangeNotifier {
  WebSocketChannel? _channel;
  String? lastReceivedMessage;
  bool isConnected = false; //웹소켓 연결 확인
  final AudioPlayer _audioPlayer = AudioPlayer(); // AudioPlayer 인스턴스 생성

  // WebSocket 연결
  void connect(String url) {
    print("연결");
    isConnected = true;
    _channel = WebSocketChannel.connect(Uri.parse(url));
  }

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
          print("시작 msg 들어옴");
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

  // 음성 재생
  Future<void> _playAudio(Uint8List audioData) async {
    try {
      // 임시 파일로 저장하여 재생
      //getTemporaryDirectory를 통해 임시 파일의 경로를 얻고, File 객체를 생성하여 데이터를 씁니다.
      String tempPath = (await getTemporaryDirectory()).path;
      File tempFile = File('$tempPath/temp_audio.mp3');
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
  void sendMessage(String message) {
    print("Sending message...");
    if (_channel != null) {
      _channel!.sink.add(message);
      print("메시지 전송됨: $message");
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
