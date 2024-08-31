import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

class Bubble extends StatelessWidget {
  final Map<String, dynamic> chat;

  const Bubble({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    bool isUser = chat['isUser'];
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: isUser
          ? Container(
              //사용자인 경우
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.66),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 10, 62, 104),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.8), // 그림자의 색상
                    offset: const Offset(2, 2), // 그림자의 위치 (x, y)
                    blurRadius: 4, // 그림자의 흐림 정도
                    spreadRadius: 1, // 그림자의 확산 정도
                  )
                ],
              ),
              child: Text(
                chat['text'],
                style: TextStyle(
                    color: isUser ? Colors.white : Colors.black,
                    fontSize: 23,
                    fontFamily: "IBMPlexSansKRRegular"),
              ),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start, //?
              children: [
                const SizedBox(
                  width: 4,
                ),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Pallete.sodamLightYellow,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'lib/assets/images/sodam.png', // 이미지 경로
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.66),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4), // 그림자의 색상
                        offset: const Offset(2, 2), // 그림자의 위치 (x, y)
                        blurRadius: 4, // 그림자의 흐림 정도
                        spreadRadius: 2, // 그림자의 확산 정도
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
              ],
            ),
    );
  }
}
