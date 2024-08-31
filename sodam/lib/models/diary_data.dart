// 일기 데이터를 모델링하는 Diary 클래스
class Diary {
  final String title;
  final String content;
  final DateTime date;

  Diary({
    required this.title,
    required this.content,
    required this.date,
  });

  // JSON 데이터를 Diary 객체로 변환하는 factory 생성자
  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
      title: json['title'],
      content: json['content'],
      date: DateTime.parse(json['date']),
    );
  }
}
