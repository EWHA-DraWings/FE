import 'package:sodam/models/emotion_data.dart';

class ReportData {
  final String date; // date
  final double correctRatio; // correctRatio(기억점수)
  final List<EmotionData> emotions; // EmotionData 리스트
  final String condition; // condition

  ReportData({
    required this.condition,
    required this.date,
    required this.emotions,
    required this.correctRatio,
  });

  //과거 리포트 가져올 때
  factory ReportData.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> emotionMap = json['emotions'];
    double correctRatio = json['correctRatio'] ?? 0;

    // EmotionData 리스트 생성
    List<EmotionData> emotionsList = emotionMap.entries
        .map((entry) => EmotionData(
              emotion: entry.key,
              percentage: entry.value.toDouble(),
            ))
        .toList();

    return ReportData(
      date: json['date'],
      condition: json['conditions'],
      emotions: emotionsList,
      correctRatio: correctRatio,
    );
  }

  static List<ReportData> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ReportData.fromJson(json)).toList();
  }
}
