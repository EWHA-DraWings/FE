// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';

// class WebSocketProvider with ChangeNotifier {
//   WebSocketChannel? _channel;

//   // 웹소켓 연결 시작
//   void connect(String url) {
//     _channel = WebSocketChannel.connect(Uri.parse(url));
//     notifyListeners();
//   }

//   // 웹소켓 채널 가져오기
//   WebSocketChannel? get channel => _channel;

//   // 웹소켓 메시지 전송
//   void sendMessage(String message) {
//     _channel?.sink.add(message);
//   }

// //   // 웹소켓 닫기
// //   void close() {
// //     _channel?.sink.close();
// //     _channel = null;
// //     notifyListeners();
// //   }
// // }
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';

// class WebSocketProvider with ChangeNotifier {
//   WebSocketChannel? _channel;
//   String? _lastReceivedMessage; // 마지막 수신 메시지 저장
//   // 웹소켓 연결 시작
//   void connect(String url) {
//     _channel = WebSocketChannel.connect(Uri.parse(url));
//     // Listen for incoming messages
//     _channel!.stream.listen((message) {
//       handleMessage(message);
//     });
//     notifyListeners();
//   }

//   // Handle incoming WebSocket messages
//   void handleMessage(String message) {
//     final decodedMessage = jsonDecode(message);
//     // Notify listeners with the incoming message
//     notifyListeners();
//   }
//   // 마지막 수신된 메시지 getter
//   String? get lastReceivedMessage => _lastReceivedMessage;

//   // 웹소켓 채널 가져오기
//   WebSocketChannel? get channel => _channel;

//   // 웹소켓 메시지 전송
//   void sendMessage(Uint8List audioBytes) {
//     _channel?.sink.add(audioBytes);
//   }
//   // 웹소켓 시작 메시지 전송
//   void sendStartMessage(String messages) {
//     _channel?.sink.add(messages);
//   }

//   // 웹소켓 닫기
//   void close() {
//     _channel?.sink.close();
//     _channel = null;
//     notifyListeners();
//   }
// }
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:async';

class WebSocketProvider with ChangeNotifier {
  WebSocketChannel? _channel;
  String? _lastReceivedMessage; // Store the last received message
  final StreamController<String> _messageController =
      StreamController<String>.broadcast(); // Make it a broadcast stream

  // Start the WebSocket connection
  void connect(String url) {
    _channel = WebSocketChannel.connect(Uri.parse(url));

    // Listen for incoming messages
    _channel!.stream.listen((message) {
      handleMessage(message);
    }, onError: (error) {
      print("WebSocket Error: $error");
      _messageController
          .addError(error); // Handle errors in the broadcast stream
    }, onDone: () {
      print("WebSocket connection closed");
      close(); // Close the provider when the channel is done
    });

    notifyListeners();
  }

  // Handle incoming WebSocket messages
  void handleMessage(String message) {
    _lastReceivedMessage = message; // Store the last received message
    final decodedMessage = jsonDecode(message);

    // Notify listeners with the incoming message
    _messageController.add(message); // Add the message to the broadcast stream
    notifyListeners();
  }

  // Get the last received message
  String? get lastReceivedMessage => _lastReceivedMessage;

  // Get the broadcast stream
  Stream<String> get messageStream => _messageController.stream;

  // Get the WebSocket channel
  WebSocketChannel? get channel => _channel;

  // Send audio bytes via WebSocket
  void sendMessage(Uint8List audioBytes) {
    _channel?.sink.add(audioBytes);
  }

  // Send a start message via WebSocket
  void sendStartMessage(String messages) {
    _channel?.sink.add(messages);
  }

  // Close the WebSocket connection
  void close() {
    _channel?.sink.close();
    _channel = null;
    _messageController.close(); // Close the broadcast stream
    notifyListeners();
  }
}
