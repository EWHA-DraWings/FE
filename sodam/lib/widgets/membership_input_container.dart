import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sodam/pallete.dart';

class MembershipInputContainer extends StatelessWidget {
  final double height;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const MembershipInputContainer({
    super.key,
    required this.height,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.85,
      height: height,
      decoration: BoxDecoration(
        color: Pallete.signinInputGray,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center, // Center the child inside the container
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        textAlign: TextAlign.center, // Center the text inside the TextField
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero, // Remove extra padding
        ),
        style: TextStyle(
          fontSize: height <= 60 ? 15 : 20,
          fontFamily: 'IBMPlexSansKRRegular',
        ),
      ),
    );
  }
}
