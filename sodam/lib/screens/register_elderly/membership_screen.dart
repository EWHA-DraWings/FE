import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/register_elderly/membership_name_screen.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({super.key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.sodamGreen,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // 좌우 여백 추가
              child: const Align(
                alignment: Alignment.centerLeft, // 왼쪽 정렬
                child: Text(
                  "회원가입",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Gugi",
                    fontWeight: FontWeight.w600,
                    color: Pallete.sodamDarkPink, // 텍스트 색상 (필요에 따라 조정)
                  ),
                ),
              ),
            ),
          ),
          const Flexible(
            flex: 2,
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                "가입유형을 \n선택해주세요.",
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'IBMPlexSansKRRegular',
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MembershipNameScreen(), // 사용자 화면 => 나중에 다르게 랜더링 해야될듯?
                        ),
                      );
                    },
                    child: Container(
                      width: 300,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Pallete.sodamBeige.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 11,
                          horizontal: 100,
                        ),
                        child: Text(
                          "사용자",
                          style: TextStyle(
                            fontSize: 35,
                            fontFamily: "PoorStory",
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MembershipNameScreen(), // 보호자 화면
                        ),
                      );
                    },
                    child: Container(
                      width: 300,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Pallete.sodamBeige.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 11,
                          horizontal: 100,
                        ),
                        child: Text(
                          "보호자",
                          style: TextStyle(
                            fontSize: 35,
                            fontFamily: "PoorStory",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 70,
          ),
        ],
      ),
    );
  }
}
