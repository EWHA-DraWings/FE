import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  final Map<String, dynamic> chat;

  const Bubble({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    bool isUser = chat['isUser'];
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        decoration: BoxDecoration(
          color: isUser
              ? const Color.fromARGB(255, 10, 62, 104)
              : Colors.grey[300],
          borderRadius: isUser
              ? const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // 그림자의 색상
              offset: const Offset(1, 2), // 그림자의 위치 (x, y)
              blurRadius: 4, // 그림자의 흐림 정도
              spreadRadius: 1, // 그림자의 확산 정도
            ),
          ],
        ),
        child: Text(
          chat['text'],
          style: TextStyle(
              color: isUser ? Colors.white : Colors.black,
              fontSize: 23,
              fontFamily: "IBMPlexSansKRRegular"),
        ),
      ),
    );
  }
}
