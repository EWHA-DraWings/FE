import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:sodam/models/login_data.dart';
import 'package:sodam/screens/chat/websocket_provider.dart';
import 'package:sodam/screens/login_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
