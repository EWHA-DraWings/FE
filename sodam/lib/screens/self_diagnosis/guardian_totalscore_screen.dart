import 'package:flutter/material.dart';

class GuardianTotalscoreScreen extends StatelessWidget {
  final int score;
  const GuardianTotalscoreScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('점수 페이지'),
      ),
      body: Center(
        child: Text(
          '총 점수: $score',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
