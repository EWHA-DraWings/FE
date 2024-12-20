import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:sodam/models/login_data.dart';
import 'package:sodam/global.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/main_screen.dart';
import 'package:sodam/screens/time_select_screen.dart';
import 'package:sodam/widgets/login_input_container.dart';
import 'package:sodam/widgets/move_to_membership_button.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? userInfo = ""; // user의 정보를 저장하기 위한 변수
  static const storage =
      FlutterSecureStorage(); // FlutterSecureStorage를 storage로 저장

  @override
  void initState() {
    super.initState();

    // 비동기로 flutter secure storage 정보를 불러오는 작업.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    // read 함수를 통하여 key값이 login인 정보를 불러옴.
    userInfo = await storage.read(key: "login");
    print("유저정보읽기$userInfo");

    // user의 정보가 이미 존재한다면 바로 메인 페이지로 넘어가게 합니다.
    if (userInfo != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const MainScreen(isGuardian: false), // 이 정보도 수정 필요
        ),
      );
    }
  }

  // 로그인 버튼 누르면 실행
  Future<void> loginAction(String id, String password) async {
    try {
      var param = {
        'id': id,
        'password': password,
      };

      // 로그인 API 요청
      final response = await http.post(
        Uri.parse('http://${Global.ipAddr}:3000/api/auth/login'),
        headers: {
          "Content-Type": "application/json", // JSON 형식으로 요청
        },
        body: json.encode(param), // JSON 형식으로 바꿔서 body에 추가
      );

      if (response.statusCode == 200) {
        // JSON 응답 파싱
        final jsonBody = json.decode(response.body);
        print(jsonBody);

        // isElderly 값 가져오기
        bool isElderly = jsonBody['isElderly'];

        // 응답 json에서 사용자 ID를 추출해 LoginData 객체를 생성
        var loginData = LoginData.fromJson(jsonBody);

        // FlutterSecureStorage에 로그인 정보를 저장
        await storage.write(
          key: 'login',
          value: jsonEncode(loginData.toJson()),
        );
        print("logindata $loginData");

        // Provider를 사용하여 상태 관리
        Provider.of<LoginDataProvider>(context, listen: false)
            .setLoginData(loginData);

        print('접속 성공! userID: ${loginData.user_id}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            //builder: (context) => MainScreen(isGuardian: !isElderly),
            builder: (context) => isElderly
                ? const TimeSelectScreen()
                : MainScreen(isGuardian: !isElderly),
          ),
        );
      } else if (response.statusCode == 401) {
        print('로그인 실패: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('401: 로그인에 실패했습니다. 다시 시도해주세요.')),
        );
      } else {
        print('로그인 실패: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('500: 서버 오류로 로그인에 실패했습니다. 다시 시도해주세요.')),
        );
      }
    } catch (e) {
      print('예외 발생: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Pallete.mainWhite,
      appBar: AppBar(
        backgroundColor: Pallete.mainWhite,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "안녕하세요, 소담이에요!",
                    style: TextStyle(
                      color: Pallete.mainBlack,
                      fontFamily: "IBMPlexSansKRBold",
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "다시 만나 반가워요 :)",
                    style: TextStyle(
                      color: Pallete.mainBlack,
                      fontFamily: "IBMPlexSansKRBold",
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.1),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '아이디',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: "IBMPlexSansKRRegular",
                      color: Pallete.mainBlack,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              LoginInputContainer(
                width: 220,
                height: 60,
                controller: idController,
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '비밀번호',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: "IBMPlexSansKRRegular",
                      color: Pallete.mainBlack,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              LoginInputContainer(
                width: 220,
                height: 60,
                controller: passwordController,
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: screenWidth * 0.9,
                height: 59,
                child: ElevatedButton(
                  onPressed: () async {
                    await loginAction(
                        idController.text, passwordController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Pallete.mainBlack,
                    backgroundColor: Pallete.mainBlue, // 버튼 배경 색상
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // 버튼 모서리 둥글기
                    ),
                  ),
                  child: const Text(
                    '로그인',
                    style: TextStyle(
                      color: Pallete.mainWhite,
                      fontSize: 20,
                      fontFamily: 'IBMPlexSansKRBold',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Spacer 대신 SizedBox 추가
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "아직 계정이 없으신가요?",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(width: 10),
                    MoveToMembershipButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
