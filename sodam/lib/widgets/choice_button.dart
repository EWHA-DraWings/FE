import 'package:flutter/material.dart';
import 'package:sodam/pallete.dart';

class ChoiceButton extends StatelessWidget {
  final String text;
  final int val, index;
  final VoidCallback? onPressed;
  final List<String?> selectedOptions;

  const ChoiceButton({
    super.key,
    required this.text,
    required this.val,
    this.onPressed,
    required this.selectedOptions,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(300, 50),
          backgroundColor: selectedOptions[index] == val.toString()
              ? const Color(0xFFD768C5)
              : Pallete.mainGray,
          foregroundColor: selectedOptions[index] == val.toString()
              ? Colors.white
              : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'IBMPlexSansKRRegular',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
