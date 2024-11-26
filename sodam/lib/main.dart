import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:sodam/models/login_data.dart';
import 'package:sodam/screens/chat/websocket_provider.dart';
import 'package:sodam/screens/login_screen.dart';

// 핸들러 함수
Future<void> backgroundMessageHandler(RemoteMessage message) async {
  print("백그라운드에서 푸시 메시지 수신: ${message.notification?.title}");
  // 여기서 받은 메시지를 처리하는 로직을 작성
  // 예: 알림을 띄우거나 앱의 특정 상태를 변경하는 등의 작업
  // 예시로, 앱이 백그라운드에서 메시지를 받을 때 앱 내부에서 적절한 처리를 수행
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화
  await Firebase.initializeApp();

  // 백그라운드 푸시 알림 처리 핸들러 설정
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

  await initialization(null);
  await initializeDateFormatting();

  runApp(const MainApp());
}

Future initialization(BuildContext? context) async {
  // Splash screen for 3 seconds
  await Future.delayed(const Duration(seconds: 3));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginDataProvider()),
        ChangeNotifierProvider(
            create: (_) =>
                WebSocketProvider()), // Provide the LoginDataProvider
      ],
      child: MaterialApp(
        builder: (context, child) {
          return child!;
        },
        home: const LoginScreen(), // Your initial screen
      ),
    );
  }
}
