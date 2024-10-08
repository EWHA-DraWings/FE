import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sodam/screens/login_screen.dart';

class LogoutButtonWidget extends StatefulWidget {
  const LogoutButtonWidget({
    super.key,
  });

  @override
  State<LogoutButtonWidget> createState() => _LogoutButtonWidgetState();
}

class _LogoutButtonWidgetState extends State<LogoutButtonWidget> {
  static const storage = FlutterSecureStorage();
  dynamic userInfo = '';
  logout() async {
        await storage.delete(key: 'login');//login 정보를 flutter secure storage에서 없앰
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        logout();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        fixedSize: const Size(120, 30),
        elevation: 0,
      ),
      child: const Center(
        child: Text(
          "로그아웃",
          style: TextStyle(
            color: Color.fromARGB(255, 129, 129, 134),
            fontSize: 18,
            fontFamily: "IBMPlexSansKRRegular",
            decoration: TextDecoration.underline, // 밑줄 추가
            decorationColor: Color.fromARGB(255, 129, 129, 134), // 밑줄 색상
          ),
        ),
      ),
    );
  }
}
