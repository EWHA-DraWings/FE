import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogoutButtonWidget extends StatefulWidget {
  const LogoutButtonWidget({
    super.key,
  });

  @override
  State<LogoutButtonWidget> createState() => _LogoutButtonWidgetState();
}

class _LogoutButtonWidgetState extends State<LogoutButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // 버튼 클릭 시 동작. (로그아웃)
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 240, 234, 222),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      ),
      child: const Text(
        "로그아웃",
        style: TextStyle(
          color: Color.fromARGB(255, 134, 134, 134),
          fontSize: 18,
        ),
      ),
    );
  }
}
