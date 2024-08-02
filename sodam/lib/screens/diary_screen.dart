import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.sodamGreen,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Pallete.sodamGreen,
        title: const Text(
          "일기장",
          style: TextStyle(
            fontSize: 30,
            fontFamily: "PoorStory",
            color: Pallete.sodamBeige,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0), // 선의 높이
          child: Container(
            color: Pallete.sodamBeige, // 선의 색상
            height: 3, // 선의 두께
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 330,
              height: 70,
              decoration: BoxDecoration(
                color: Pallete.sodamBeige,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  "5월  27일 (화)",
                  style: TextStyle(
                    fontFamily: "IBMPlexSansKRRegular",
                    fontSize: 35,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 330,
              height: 600,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                color: Pallete.sodamBeige,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: SingleChildScrollView(
                  //스크롤 가능하게
                  child: Text(
                    """ 오늘은 아침부터 비가 내렸다. 비 소리를 들으니 마음이 차분해지는 것 같았다. 아침 식사로는 따뜻한 미역국을 끓여 먹었다. 비 오는 날에는 따뜻한 국물이 최고다.
  비가 와서 외출은 못했지만 집에서 할 일이 많았다. 오래된 사진첩을 정리하고, 손자들이 보내준 편지를 읽었다. 손자들이 쓴 편지를 읽으니 눈물이 핑 돌았다. 세월이 참 빠르다는 생각이 들었다.
  점심 후에는 재봉틀로 낡은 옷을 수선했다. 예전에 배운 재봉 솜씨가 아직 녹슬지 않았다. 저녁에는 간단히 계란말이와 나물반찬으로 식사를 하고, 드라마를 보면서 하루를 마무리했다.""",
                    style: TextStyle(
                      fontFamily: "IBMPlexSansKRRegular",
                      fontSize: 30,
                      height: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DiaryButtonWidget(
                  text: "<",
                  backgroundColor: Color.fromARGB(255, 205, 205, 205),
                ),
                DiaryButtonWidget(
                  text: "듣기",
                  backgroundColor: Pallete.sodamBeige,
                ),
                DiaryButtonWidget(
                  text: ">",
                  backgroundColor: Color.fromARGB(255, 205, 205, 205),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DiaryButtonWidget extends StatelessWidget {
  final String text;
  final Color backgroundColor;

  const DiaryButtonWidget({
    super.key,
    required this.text,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // 버튼 1의 동작
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, // 버튼 배경색
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // 버튼의 모서리 둥글기
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: "IBMPlexSansKRBold",
            color: Colors.black, // 텍스트 색상
          ),
        ),
      ),
    );
  }
}
