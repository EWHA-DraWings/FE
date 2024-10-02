import 'package:flutter/material.dart';

class BuildEmotionRow extends StatelessWidget {
  const BuildEmotionRow({
    super.key,
    required this.emotion,
    required this.color,
  });

  final String emotion;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          emotion,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: "IBMPlexSansKRRegular",
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
