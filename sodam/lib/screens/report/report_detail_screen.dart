import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/widgets/title_widget.dart';

class ReportDetailScreen extends StatelessWidget {
  const ReportDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const TitleWidget(
            backgroundColor: Pallete.mainBlue,
            textColor: Colors.white,
            text: '기억 점수',
          ),
          Container(
            width: screenWidth * 0.8,
            height: 80,
            decoration: BoxDecoration(
              color: Pallete.sodamButtonPurple,
              borderRadius: BorderRadius.circular(20),
            ),
          )
        ],
      ),
    );
  }
}
