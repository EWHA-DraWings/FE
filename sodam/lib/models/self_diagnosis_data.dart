class SelfDiagnosisData {
  final String type; //자가진단 타이
  final String date; //검사 날짜
  final int score; //자가진단 점수

  SelfDiagnosisData(
      {required this.type, required this.date, required this.score});

  //res 처리하기
  factory SelfDiagnosisData.fromJson(Map<String, dynamic> json) {
    return SelfDiagnosisData(
      date: json['date'].substring(0, 10),
      type: json['questionnaireType'],
      score: json['score'],
    );
  }

  //객체 리스트로
  static List<SelfDiagnosisData> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SelfDiagnosisData.fromJson(json)).toList();
  }
}
