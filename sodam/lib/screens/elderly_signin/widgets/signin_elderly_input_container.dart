import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sodam/pallete.dart';

class SigninElderlyInputContainer extends StatefulWidget {
  final double height;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const SigninElderlyInputContainer({
    super.key,
    required this.height,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  _SigninElderlyInputContainerState createState() =>
      _SigninElderlyInputContainerState();
}

class _SigninElderlyInputContainerState
    extends State<SigninElderlyInputContainer> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.85,
      height: widget.height,
      decoration: BoxDecoration(
        color: Pallete.signinInputGray,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _isFocused
              ? Colors.black.withOpacity(0.7)
              : Colors.transparent, // 포커스 시 파란 테두리
          width: 2.0,
        ),
      ),
      alignment: Alignment.center,
      child: Center(
        child: TextFormField(
          controller: widget.controller,
          obscureText: widget.obscureText,
          validator: widget.validator,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          textAlign: TextAlign.center,
          focusNode: _focusNode, // FocusNode를 적용
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: widget.height < 60
                ? const EdgeInsets.only(bottom: 8)
                : EdgeInsets.zero,
          ),
          style: const TextStyle(
            fontSize: 30,
            fontFamily: 'IBMPlexSansKRRegular',
          ),
        ),
      ),
    );
  }
}
