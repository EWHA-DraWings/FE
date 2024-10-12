//기억점수 모델
class MemoryScoreData {
  final String date; //날짜
  final double correctRatio; //정답률(백분율)
  final double cdrScore; //cdr 점수
  final int questionCount; //문제 개수
  final int correctCount; //정답 개수

  MemoryScoreData({
    required this.cdrScore,
    required this.questionCount,
    required this.correctCount,
    required this.date,
    required this.correctRatio,
  });

  factory MemoryScoreData.fromJson(Map<String, dynamic> json) {
    return MemoryScoreData(
      date: json['date'],
      cdrScore: json['cdrScore'].toDouble(),
      correctRatio: json['correctRatio'].toDouble(),
      correctCount: json['correctCount'],
      questionCount: json['questionCount'],
    );
  }
}
