import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/register_elderly/membership_screen.dart';
import 'package:sodam/widgets/membership_input_container.dart';
import 'package:sodam/widgets/membership_next_button.dart';

class MemebershipExtrainfoScreen extends StatefulWidget {
  const MemebershipExtrainfoScreen({super.key});

  @override
  State<MemebershipExtrainfoScreen> createState() =>
      _MemebershipExtrainfoScreenState();
}

class _MemebershipExtrainfoScreenState
    extends State<MemebershipExtrainfoScreen> {
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
                    color: Pallete.sodamDarkPink,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 4,
            child: Container(
              //color: Colors.green, // 두 번째 영역의 배경색
              child: const Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "앱 사용을 위해\n추가 정보를\n받고 있어요.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'IBMPlexSansKRRegular',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "앱의 기억점수 측정시에만 사용되는 정보에요. 탈퇴시 자동으로\n삭제되며, 앱 외의 다른 곳에서 사용되지 않으니 안심하세요!",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'IBMPlexSansKRRegular',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "사용자님의 정보를 입력해주세요.",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'IBMPlexSansKRRegular',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 6,
            child: Container(
              //color: Colors.blue, // 세 번째 영역의 배경색
              child: const Padding(
                padding: EdgeInsets.only(top: 0.0), // 위쪽 여백 제거
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    MembershipInputContainer(
                      width: 300,
                      height: 50,
                      hintText: "생년월일",
                    ),
                    SizedBox(height: 20),
                    MembershipInputContainer(
                      width: 300,
                      height: 50,
                      hintText: "전화번호",
                    ),
                    SizedBox(height: 20),
                    MembershipInputContainer(
                      width: 300,
                      height: 50,
                      hintText: "이메일",
                    ),
                    SizedBox(height: 20),
                    MembershipInputContainer(
                      width: 300,
                      height: 50,
                      hintText: "직업",
                    ),
                    SizedBox(height: 20),
                    MembershipInputContainer(
                      width: 300,
                      height: 50,
                      hintText: "거주 지역",
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MembershipNextButton(
                      destination: MembershipScreen(), //이후에 다음 화면으로 수정
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
                //color: Colors.yellow, // 네 번째 영역의 배경색
                ),
          ),
        ],
      ),
    );
  }
}
