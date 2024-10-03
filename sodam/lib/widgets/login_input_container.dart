import 'package:flutter/material.dart';

class LoginInputContainer extends StatefulWidget {
  //이 위젯은 너비, 높이와 hintText를 지정할 수 있는 입력 컨테이너.
  final double width;
  final double height;
<<<<<<< HEAD
  final TextEditingController controller; // TextEditingController 추가
=======
  final TextEditingController controller;
>>>>>>> origin

  const LoginInputContainer({
    super.key,
    required this.width,
    required this.height,
    required this.controller,
  });

  @override
  State<LoginInputContainer> createState() => _LoginInputContainerState();
}

class _LoginInputContainerState extends State<LoginInputContainer> {
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _isFocused ? Colors.black : Colors.grey,
          width: 2.0, // 테두리 두께 설정
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'IBMPlexSansKRRegular',
          ),
        ),
      ),
    );
  }
}
