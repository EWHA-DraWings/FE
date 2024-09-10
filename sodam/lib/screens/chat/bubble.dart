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
                color: Pallete.mainBlue,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6), // 그림자의 색상
                    offset: const Offset(1, 1), // 그림자의 위치 (x, y)
                    blurRadius: 5, // 그림자의 흐림 정도
                    spreadRadius: 1, // 그림자의 확산 정도
                  )
                ],
              ),
              child: Text(
                chat['text'],
                style: const TextStyle(
                    color: Pallete.mainWhite,
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
                    color: const Color(0xFFCDDEF8),
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
                    color: Pallete.mainGray,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4), // 그림자의 색상
                        offset: const Offset(1, 1), // 그림자의 위치 (x, y)
                        blurRadius: 10, // 그림자의 흐림 정도
                        spreadRadius: 1, // 그림자의 확산 정도
                      ),
                    ],
                  ),
                  child: Text(
                    chat['text'],
                    style: const TextStyle(
                        color: Pallete.mainBlack,
                        fontSize: 23,
                        fontFamily: "IBMPlexSansKRRegular"),
                  ),
                ),
              ],
            ),
    );
  }
}
