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
      date: json['date'].substring(0, 10),
      cdrScore: json['cdrScore'].toDouble(),
      correctRatio: json['correctRatio'].toDouble(),
      correctCount: json['correctCount'],
      questionCount: json['questionCount'],
    );
  }

  // List<dynamic>을 받아서 List<MemoryScoreData>로 변환하는 fromJson
  static List<MemoryScoreData> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MemoryScoreData.fromJson(json)).toList();
  }

  @override
  String toString() {
    return 'MemoryScoreData(date: $date, correctRatio: $correctRatio, cdrScore: $cdrScore, correctCount: $correctCount, questionCount: $questionCount)';
  }
}
