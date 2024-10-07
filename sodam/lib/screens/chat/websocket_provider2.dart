import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketProvider2 with ChangeNotifier {
  WebSocketChannel? _channel;
  String? lastReceivedMessage;
  bool isConnected = false;//웹소켓 연결 확인
  
  // WebSocket 연결
  void connect(String url) {
    isConnected = true;
    _channel = WebSocketChannel.connect(Uri.parse(url));
    _channel?.stream.listen((message) {
      lastReceivedMessage = message;
      notifyListeners(); // 상태 변경 알림
    }, onError: (error) {
      isConnected = false;
      print("WebSocket error: $error");
      // Handle any errors
    }, onDone: () {
      isConnected = false;
      print("WebSocket connection closed");
      // Handle connection closed
    });
  }
   

  bool checkConnection() {
    return isConnected;
  }

  // 메시지 전송
  void sendMessage(String message) {
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
