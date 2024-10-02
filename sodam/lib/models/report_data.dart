class ReportData {
  final String date;
  final String condition;
  final double memoryScore;

  ReportData(
    this.condition,
    this.memoryScore, {
    required this.date,
  });
}
