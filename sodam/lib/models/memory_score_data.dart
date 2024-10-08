//기억점수 모델
class MemoryScoreData {
  final String date; //날짜
  final double correctScore; //정답률(백분율)
  final double cdrScore; //cdr 점수
  final int totalCnt; //문제 개수
  final int correctCnt; //정답 개수

  MemoryScoreData({
    required this.cdrScore,
    required this.totalCnt,
    required this.correctCnt,
    required this.date,
    required this.correctScore,
  });
}
