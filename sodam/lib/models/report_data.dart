import 'package:sodam/models/emotion_data.dart';

class ReportData {
  final String diaryId;
  final String healthStatus;
  final String date;
  final double cdrScore;
  final List<EmotionData> emotions;
  final String condition;

  ReportData({
    required this.diaryId,
    required this.healthStatus,
    required this.condition,
    required this.date,
    required this.cdrScore,
    required this.emotions,
  });

  factory ReportData.fromJson(Map<String, dynamic> json) {
    return ReportData(
      diaryId: json['id'],
      healthStatus: json['healthStatus'],
      condition: json['condition'],
      date: json['date'],
      cdrScore: json['cdrScore'].toDouble(),
      emotions: json['emotion'],
    );
  }
}
