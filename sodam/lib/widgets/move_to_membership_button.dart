import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/signin_start_screen.dart';

class MoveToMembershipButton extends StatelessWidget {
  const MoveToMembershipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SigninStartScreen()),
        );
      },
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Colors.transparent), // 배경색 투명
        shadowColor:
            MaterialStateProperty.all<Color>(Colors.transparent), // 그림자 제거
        elevation: MaterialStateProperty.all<double>(0), // 그림자 높이 제거
        padding:
            MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero), // 패딩 제거
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // 모서리 반경 초기화
          ),
        ),
        side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
      ), // 테두리 제거
      child: const Text(
        "회원가입",
        style: TextStyle(
          color: Pallete.mainBlue,
          fontSize: 25,
          fontFamily: "IBMPlexSansKRBold",
        ),
      ),
    );
  }
}
