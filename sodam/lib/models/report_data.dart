import 'package:sodam/models/emotion_data.dart';

class ReportData {
  final String date; // date
  final double correctRatio; // correctRatio(기억점수)
  final List<EmotionData> emotions; // EmotionData 리스트
  final String condition; // condition

  ReportData({
    required this.condition,
    required this.date,
    required this.correctRatio,
    required this.emotions,
  });

  //과거 리포트 가져올 때
  factory ReportData.fromJsonPast(Map<String, dynamic> json) {
    String date = json['date'];
    String condition = json['conditions'];
    Map<String, dynamic> emotionMap = json['emotions'];

    // EmotionData 리스트 생성
    List<EmotionData> emotionsList = emotionMap.entries
        .map((entry) => EmotionData(
              emotion: entry.key,
              percentage: entry.value.toDouble(),
            ))
        .toList();

    return ReportData(
      date: date,
      condition: condition,
      emotions: emotionsList,
      correctRatio: json['cdrScore'],
    );
  }

  factory ReportData.fromJson(Map<String, dynamic> json) {
    // Convert emotions map to List<EmotionData>
    Map<String, dynamic> emotionsMap = json['emotions'] ?? {};
    List<EmotionData> emotionsList = emotionsMap.entries.map((entry) {
      return EmotionData(
        emotion: entry.key,
        percentage: entry.value.toDouble(),
      );
    }).toList();

    return ReportData(
      date: DateTime.parse(json['date']).toString(),
      correctRatio: json['cdrScore'] ?? -1, //기억점수 테스트(-1이면 다른 메시지로 대체)
      emotions: emotionsList,
      condition: json['conditions'] ?? 'No conditions available',
    );
  }
}
