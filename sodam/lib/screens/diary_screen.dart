import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Pallete.mainWhite,
      appBar: AppBar(
        backgroundColor: Pallete.mainWhite,
        scrolledUnderElevation: 0, //스크롤 시 appbar 색상이 바뀌는 점 해결.
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.08),
                    child: const Text(
                      "5월 27일 화요일",
                      style: TextStyle(
                        fontFamily: "IBMPlexSansKRRegular",
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.05),
                    child: TextButton(
                      //일기 내용 읽어주는 버튼
                      onPressed: () {
                        // 버튼 클릭 시 동작. 나중에 수정필요
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                      ),
                      child: Image.asset(
                        "lib/assets/images/listen.png",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.75,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: Pallete.mainGray,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: SingleChildScrollView(
                    child: Text(
                      """ 오늘은 아침부터 비가 내렸다. 비 소리를 들으니 마음이 차분해지는 것 같았다. 아침 식사로는 따뜻한 미역국을 끓여 먹었다. 비 오는 날에는 따뜻한 국물이 최고다.
  비가 와서 외출은 못했지만 집에서 할 일이 많았다. 오래된 사진첩을 정리하고, 손자들이 보내준 편지를 읽었다. 손자들이 쓴 편지를 읽으니 눈물이 핑 돌았다. 세월이 참 빠르다는 생각이 들었다.
  점심 후에는 재봉틀로 낡은 옷을 수선했다. 예전에 배운 재봉 솜씨가 아직 녹슬지 않았다. 저녁에는 간단히 계란말이와 나물반찬으로 식사를 하고, 드라마를 보면서 하루를 마무리했다.""",
                      style: TextStyle(
                        fontFamily: "IBMPlexSansKRRegular",
                        fontSize: 25,
                        height: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            // Container 위에 약간 겹치도록 조정
            bottom: screenHeight * 0.03,
            right: screenWidth * 0.03,
            child: SizedBox(
              width: 75,
              height: 75,
              child: ElevatedButton(
                onPressed: () {
                  // 버튼 클릭 시 동작. 나중에 수정필요
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.mainBlue,
                  shape: const CircleBorder(), // 원형 버튼
                  padding: EdgeInsets.zero,
                ),
                child: Image.asset(
                  "lib/assets/images/edit.png",
                  //width: 70, 왜 너비를 줘도 안먹는지 모르겠음.
                  //height: 70,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
