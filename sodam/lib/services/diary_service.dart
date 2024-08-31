import 'dart:convert'; // JSON 디코딩을 위한 패키지
import 'package:http/http.dart' as http;
import 'package:sodam/models/diary_data.dart'; // HTTP 요청을 위한 패키지

class DiaryService {
  static const String _baseUrl = 'https://your-api-url.com'; // API 기본 URL

  // 특정 날짜의 일기를 가져오는 함수
  static Future<Diary?> getDiaryForDate(DateTime date) async {
    // 날짜를 'YYYY-MM-DD' 형식으로 변환
    String formattedDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    // 백엔드 API 호출
    final response = await http.get(Uri.parse('$_baseUrl/diary?date=$formattedDate'));

    if (response.statusCode == 200) {
      // 성공적으로 응답을 받았을 경우, JSON 데이터를 파싱하여 Diary 객체 생성
      final json = jsonDecode(response.body);
      return Diary.fromJson(json);
    } else {
      // 실패한 경우 null 반환 또는 에러 처리
      return null;
    }
  }
}


