import 'package:sodam/models/emotion_data.dart';

class ReportData {
  final String date; // date
  final String? correctRatio; // correctRatio(기억점수)
  final List<EmotionData> emotions; // EmotionData 리스트
  final String condition; // condition

  ReportData({
    required this.condition,
    required this.date,
    this.correctRatio,
    required this.emotions,
  });

  //오늘 리포트 가져올 때
  factory ReportData.fromJsonToday(Map<String, dynamic> json) {
    var emotions = (json['emotions'] as Map<String, dynamic>).entries.map(
      (e) {
        return EmotionData(emotion: e.key, percentage: e.value.toDouble());
      },
    ).toList();

    return ReportData(
      date: json['date'],
      correctRatio: json['correctRatio'] != null
          ? json['correctRatio'].toString()
          : '기억 테스트 기록이 없어요.',
      emotions: emotions,
      condition: json['condition'],
    );
  }

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
      correctRatio: json['cdrScore']?.toString(), // cdrScore를 문자열로 변환
    );
  }
}

// JSON 데이터를 List<ReportData>로 변환하는 함수
//List<ReportData> parseReportDataList(List<dynamic> jsonList) {
  //return jsonList.map((json) => ReportData.fromJsonPast(json)).toList();
//}
