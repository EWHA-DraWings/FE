import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sodam/models/guardian_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/Guardian_membership/membership_elderly_extraInfo_screen.dart';
import 'package:sodam/screens/login_screen.dart';
import 'package:sodam/widgets/membership_input_container.dart';
import 'package:sodam/widgets/membership_next_button.dart';
import 'dart:convert'; //JSON 변환을 위해 필요
import 'package:intl/intl.dart'; // Date Format 사용시 사용하는 패키지

class MemebershipExtrainfoScreen extends StatefulWidget {
  final GuardianData data;
  const MemebershipExtrainfoScreen({super.key, required this.data});

  @override
  State<MemebershipExtrainfoScreen> createState() =>
      _MemebershipExtrainfoScreenState();
}

class _MemebershipExtrainfoScreenState
    extends State<MemebershipExtrainfoScreen> {
  //textField controller
  final _birthdayController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _jobController = TextEditingController();
  final _addressController = TextEditingController();

  //생년월일
  DateTime? tempPickedDate;
  DateTime _selectedDate = DateTime.now();

  //form
  final _formKey = GlobalKey<FormState>();

  void _onNextButtonPressed() async {
    //async여야 함?
    if (_formKey.currentState!.validate()) {
      final birthday = _birthdayController.text;
      final phoneNumber = _phoneController.text;
      final email = _emailController.text;
      final job = _jobController.text;
      final address = _addressController.text;

      final extraGuardianData = widget.data.copyWith(
        birth: birthday,
        phone: phoneNumber,
        email: email,
        job: job,
        address: address,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MemebershipElderlyExtraInfoScreen(
            data: extraGuardianData, //
          ),
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
                "앱의 기억점수 측정시에만 사용되는 정보에요.\n 탈퇴시 자동으로 삭제되며, 앱 외의 다른 곳에\n 사용되지 않으니 안심하세요!",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'IBMPlexSansKRRegular',
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                textAlign: TextAlign.center,
                "보호자님의 정보를 입력해주세요.",
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
                    //생년월일.
                    birthdayText(),
                    const SizedBox(height: 20),
                    MembershipInputContainer(
                      
                      height: 50,
                      
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
                    MembershipInputContainer(
                     
                      height: 50,
                      
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '이메일을 입력해주세요.';
                        }
                        if (!RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                            .hasMatch(value)) {
                          return '유효한 이메일 주소를 입력해주세요.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    MembershipInputContainer(
                      
                      height: 50,
                     
                      controller: _jobController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '직업을 입력해주세요.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    MembershipInputContainer(
                      
                      height: 50,
                      
                      controller: _addressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '거주 지역을 입력해주세요.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    //제출 버튼
                    MembershipNextButton(
                      onPressed: _onNextButtonPressed,
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
