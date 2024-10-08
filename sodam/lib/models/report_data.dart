import 'package:sodam/models/emotion_data.dart';

class ReportData {
  final String diaryId; // diaryId
  final String healthStatus; // healthStatus는 diaryId 내부에서 가져옴
  final String date; // date
  final double? correctRatio; // correctRatio
  final List<EmotionData> emotions; // EmotionData 리스트
  final String condition; // condition

  ReportData({
    required this.diaryId,
    required this.healthStatus,
    required this.condition,
    required this.date,
    this.correctRatio,
    required this.emotions,
  });

  factory ReportData.fromJson(Map<String, dynamic> json) {
    // 감정 데이터를 EmotionData 리스트로 변환
    final List<EmotionData> emotionList = (json['emotions']
            as Map<String, dynamic>)
        .entries
        .map((entry) =>
            EmotionData(emotion: entry.key, percentage: entry.value.toDouble()))
        .toList();

    // diaryId가 객체인지 문자열인지에 따라 처리
    String diaryId;
    String healthStatus;

    if (json['diaryId'] is String) {
      // diaryId가 문자열인 경우
      diaryId = json['diaryId'];
      healthStatus = "Unknown"; // healthStatus가 없으므로 기본값 설정
    } else if (json['diaryId'] is Map<String, dynamic>) {
      // diaryId가 객체인 경우
      diaryId = json['diaryId']['_id'];
      healthStatus = json['diaryId']['healthStatus'];
    } else {
      // 예상치 못한 형식의 diaryId
      diaryId = "Unknown";
      healthStatus = "Unknown";
    }

    return ReportData(
      diaryId: diaryId, // diaryId를 올바르게 추출
      healthStatus: healthStatus, // healthStatus를 추출
      date: json['date'], // 날짜 필드
      correctRatio: json['cdrScore']?.toDouble(), // cdrScore 필드 (null 처리)
      condition: json['conditions'], // condition 필드
      emotions: emotionList, // 감정 리스트로 변환된 emotions 필드
    );
  }
}
