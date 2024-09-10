import 'package:flutter/cupertino.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/widgets/membership_input_container.dart';

class BirthdayInputWidget extends StatelessWidget {
  const BirthdayInputWidget({
    super.key,
    required TextEditingController yearController,
    required TextEditingController monthController,
    required TextEditingController dayController,
  })  : _yearController = yearController,
        _monthController = monthController,
        _dayController = dayController;

  final TextEditingController _yearController;
  final TextEditingController _monthController;
  final TextEditingController _dayController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: MembershipInputContainer(
            height: 40,
            controller: _yearController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '년을 입력해주세요.';
              }
              if (value.length != 4) {
                return '연도는 4자리로 입력해주세요.';
              }
              return null;
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "년",
            style: TextStyle(
              color: Pallete.mainBlack,
              fontSize: 20,
              fontFamily: "IBMPlexSansKRRegular",
            ),
          ),
        ),
        SizedBox(
          width: 60,
          child: MembershipInputContainer(
            height: 40,
            controller: _monthController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '월을 입력해주세요.';
              }
              if (int.tryParse(value) == null ||
                  int.parse(value) < 1 ||
                  int.parse(value) > 12) {
                return '월은 1부터 12까지 입력 가능합니다.';
              }
              return null;
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "월",
            style: TextStyle(
              color: Pallete.mainBlack,
              fontSize: 20,
              fontFamily: "IBMPlexSansKRRegular",
            ),
          ),
        ),
        SizedBox(
          width: 60,
          child: MembershipInputContainer(
            height: 40,
            controller: _dayController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '일을 입력해주세요.';
              }
              if (int.tryParse(value) == null ||
                  int.parse(value) < 1 ||
                  int.parse(value) > 31) {
                return '일은 1부터 31까지 입력 가능합니다.';
              }
              return null;
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "일",
            style: TextStyle(
              color: Pallete.mainBlack,
              fontSize: 20,
              fontFamily: "IBMPlexSansKRRegular",
            ),
          ),
        ),
      ],
    );
  }
}
