class MemoryScoreData {
  final String date;
  final double score; //정답률(백분율)
  final double cdr; //cdr 점수

  MemoryScoreData({
    required this.date,
    required this.score,
    required this.cdr,
  });
}
