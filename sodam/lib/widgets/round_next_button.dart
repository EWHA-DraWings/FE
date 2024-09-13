import 'package:flutter/material.dart';

class RoundNextButton extends StatelessWidget {
  final String btnText;
  final String emoji;
  final Color btnColor;
  final Widget screen;

  const RoundNextButton({
    super.key,
    required this.btnText,
    required this.btnColor,
    required this.emoji,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        }, //나중에 함수 추가하기
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: btnColor,
          alignment: Alignment.centerLeft,
          elevation: 3,
        ),
        child: Row(
          children: [
            //emoji
            Text(
              emoji,
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              btnText,
              style: const TextStyle(
                fontSize: 25,
                color: Color(0xFF3E3E3E),
                fontFamily: 'IBMPlexSansKRRegular',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
