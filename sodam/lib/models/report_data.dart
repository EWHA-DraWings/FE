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
      correctRatio: json['correctRatio']
          ? json['correctRatio'].toString()
          : '기억 테스트 기록이 없어요.',
      emotions: emotions,
      condition: json['condition'],
    );
  }

  //과거 리포트 가져올 때
  // factory ReportData.fromJsonPast(Map<String, dynamic> json) {
  //   // 감정 데이터를 EmotionData 리스트로 변환
  //   final List<EmotionData> emotionList = (json['emotions']
  //           as Map<String, dynamic>)
  //       .entries
  //       .map((entry) =>
  //           EmotionData(emotion: entry.key, percentage: entry.value.toDouble()))
  //       .toList();

  //   // diaryId가 객체인지 문자열인지에 따라 처리
  //   String diaryId;
  //   String healthStatus;

  //   if (json['diaryId'] is String) {
  //     // diaryId가 문자열인 경우
  //     diaryId = json['diaryId'];
  //     healthStatus = "Unknown"; // healthStatus가 없으므로 기본값 설정
  //   } else if (json['diaryId'] is Map<String, dynamic>) {
  //     // diaryId가 객체인 경우
  //     diaryId = json['diaryId']['_id'];
  //     healthStatus = json['diaryId']['healthStatus'];
  //   } else {
  //     // 예상치 못한 형식의 diaryId
  //     diaryId = "Unknown";
  //     healthStatus = "Unknown";
  //   }

  //   return ReportData(
  //     diaryId: diaryId, // diaryId를 올바르게 추출
  //     healthStatus: healthStatus, // healthStatus를 추출
  //     date: json['date'], // 날짜 필드
  //     correctRatio: json['cdrScore']?.toDouble(), // cdrScore 필드 (null 처리)
  //     condition: json['conditions'], // condition 필드
  //     emotions: emotionList, // 감정 리스트로 변환된 emotions 필드
  //   );
  // }
}
