import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sodam/models/guardian_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/login_screen.dart';
import 'package:sodam/widgets/membership_input_container.dart';
import 'dart:convert'; //JSON 변환을 위해 필요
import 'package:intl/intl.dart'; // Date Format 사용시 사용하는 패키지
import 'package:http/http.dart' as http; // http 패키지 추가

class MemebershipElderlyExtraInfoScreen extends StatefulWidget {
  final GuardianData data;
  const MemebershipElderlyExtraInfoScreen({super.key, required this.data});

  @override
  State<MemebershipElderlyExtraInfoScreen> createState() =>
      _MemebershipElderlyExtraInfoScreenstate();
}

class _MemebershipElderlyExtraInfoScreenstate
    extends State<MemebershipElderlyExtraInfoScreen> {
  //textField controller
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _addressController = TextEditingController();
  final _conditionController = TextEditingController();

  //생년월일
  DateTime? tempPickedDate;
  DateTime _selectedDate = DateTime.now();

  //form
  final _formKey = GlobalKey<FormState>();

  void _onSubmitButtonPressed() async {
    //async여야 함?
    if (_formKey.currentState!.validate()) {
      final elderlyName = _nameController.text;
      final elderlyPhone = _phoneController.text;
      final elderlyBirthday = _birthdayController.text;
      final elderlyAddress = _addressController.text;
      final existingConditions = _conditionController.text;

      final totalGuardianData = widget.data.copyWith(
        existingConditions: existingConditions,
        elderlyName: elderlyName,
        elderlyPhone: elderlyPhone,
        elderlyBirthday: elderlyBirthday,
        elderlyAddress: elderlyAddress,
      );

      //잘 전달 되었는지 콘솔에 출력해봄.잘 된다!
      print('Collected Guardian Data:');
      print('Name: ${totalGuardianData.name}');
      print('Role: ${totalGuardianData.role}');
      print('ID: ${totalGuardianData.id}');
      print('Password: ${totalGuardianData.password}');
      print('Birth: ${totalGuardianData.birth}');
      print('Phone: ${totalGuardianData.phone}');
      print('Email: ${totalGuardianData.email}');
      print('Job: ${totalGuardianData.job}');
      print('role: ${totalGuardianData.role}');
      print('elderlyName: ${totalGuardianData.elderlyName}');
      print('elderlyPhone: ${totalGuardianData.elderlyPhone}');
      print('elderlyAddress: ${totalGuardianData.elderlyAddress}');
      print('elderlyBirthday: ${totalGuardianData.elderlyBirthday}');
      print('existingConditions: ${totalGuardianData.existingConditions}');

      //백엔드에 전송할 데이터를 Map으로 생성
      final Map<String, dynamic> requestBody = {
        //guardian info
        "id": totalGuardianData.id,
        "name": totalGuardianData.name,
        "password": totalGuardianData.password,
        "email": totalGuardianData.email,
        "phone": totalGuardianData.phone,
        "address": totalGuardianData.address,
        "birth": totalGuardianData.birth,
        "job": totalGuardianData.job,
        "role": totalGuardianData.role,
        //elderly info
        "elderlyName": totalGuardianData.elderlyName,
        "elderlyPhone": totalGuardianData.elderlyPhone,
        "elderlyAddress": totalGuardianData.elderlyAddress,
        "elderlyBirthday": totalGuardianData.elderlyBirthday,
        "existingConditions": totalGuardianData.existingConditions,
      };
      //서버 연동 전, json 형태로 잘 전달되는지 출력
      String jsonString = jsonEncode(requestBody);
      print('Request Body in JSON format: $jsonString');
      // 백엔드로 HTTP POST 요청 보내기
      // final url = Uri.parse(
      //     'https://your-backend-url.com/api/register'); // 실제 API 엔드포인트로 변경 필요
      // final response = await http.post(
      //   url,
      //   headers: {'Content-Type': 'application/json'},
      //   body: jsonEncode(requestBody),
      // );

      // // 서버 응답 결과에 따라서 처리
      // if (response.statusCode == 200) {
      //   // 서버로부터의 성공 응답 처리
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => const LoginScreen(), // 회원가입 후 로그인 화면으로 이동
      //     ),
      //   );
      // } else {
      //   // 서버로부터의 실패 응답 처리
      //   print('Failed to register: ${response.body}');
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text('회원가입에 실패했습니다. 다시 시도해주세요.')),
      //   );
      // }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(), // 회원가입 후 로그인 화면으로 이동
        ),
      );
    }
  }

  //생년월일 위젯
  Widget birthdayText() {
    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        color: Pallete.sodamYellow.withOpacity(0.5), // 배경색
        borderRadius: BorderRadius.circular(10), // borderRadius
      ),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.mediumImpact();
          _selectDate();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              enabled: false,
              decoration: const InputDecoration(
                hintText: '생년월일을 선택해주세요',
                hintStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
                border: InputBorder.none,
              ),
              controller: _birthdayController,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  _selectDate() async {
    DateTime? pickedDate = await showModalBottomSheet<DateTime>(
      backgroundColor: ThemeData.light().scaffoldBackgroundColor,
      context: context,
      builder: (context) {
        // DateTime tempPickedDate;
        return SizedBox(
          height: 300,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CupertinoButton(
                    child: const Text('취소'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  CupertinoButton(
                    child: const Text('완료'),
                    onPressed: () {
                      Navigator.of(context).pop(tempPickedDate);
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ],
              ),
              const Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: CupertinoDatePicker(
                  backgroundColor: ThemeData.light().scaffoldBackgroundColor,
                  minimumYear: 1900,
                  maximumYear: DateTime.now().year,
                  initialDateTime: DateTime.now(),
                  maximumDate: DateTime.now(),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime dateTime) {
                    tempPickedDate = dateTime;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _birthdayController.text = pickedDate.toString();
        convertDateTimeDisplay(_birthdayController.text);
      });
    }
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    return _birthdayController.text = serverFormater.format(displayDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.sodamIvory,
      appBar: AppBar(
        backgroundColor: Pallete.sodamIvory,
        foregroundColor: Pallete.sodamDarkPink, //글씨 색
        title: const Text(
          "회원가입",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            fontFamily: "Gugi",
          ),
        ),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "앱 사용을 위해\n추가 정보를 받고 있어요.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'IBMPlexSansKRRegular',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                textAlign: TextAlign.center,
                "앱의 기억점수 측정시에만 사용되는 정보에요.\n 탈퇴시 자동으로 삭제되며, 앱 외의 다른 곳에서\n 사용되지 않으니 안심하세요!",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'IBMPlexSansKRRegular',
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                textAlign: TextAlign.center,
                "보호자님과 연동할 \n사용자님의 정보를 입력해주세요.",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'IBMPlexSansKRRegular',
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(top: 0.0), // 위쪽 여백 제거
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    MembershipInputContainer(
                      width: 300,
                      height: 50,
                      hintText: "이름",
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '이름을 입력해주세요.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    MembershipInputContainer(
                      width: 300,
                      height: 50,
                      hintText: "전화번호",
                      controller: _phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '전화번호를 입력해주세요.';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return '전화번호는 숫자만 입력 가능합니다.';
                        }
                        if (value.length < 10 || value.length > 15) {
                          return '전화번호는 10자 이상 15자 이하이어야 합니다.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    //생년월일.
                    birthdayText(),
                    const SizedBox(height: 20),
                    MembershipInputContainer(
                      width: 300,
                      height: 50,
                      hintText: "거주 지역",
                      controller: _addressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '거주 지역을 입력해주세요.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    MembershipInputContainer(
                      width: 300,
                      height: 50,
                      hintText: "현재 가지고 있는 질환/질병, 건강상태",
                      controller: _conditionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '건강상태를 입력해주세요. 없는 경우 "없음"이라고 기입해주세요.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    //제출 버튼
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: _onSubmitButtonPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Pallete.sodamNewDarkPink, // 버튼 색상
                          padding: const EdgeInsets.symmetric(
                              horizontal: 55, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // 버튼 모서리 둥글기
                          ),
                        ),
                        child: const Text(
                          "가입하기",
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'PoorStory',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
