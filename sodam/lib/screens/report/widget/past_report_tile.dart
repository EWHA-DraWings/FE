import 'package:flutter/material.dart';
import 'package:sodam/models/emotion_data.dart';
import 'package:sodam/pallete.dart';
import 'package:sodam/screens/report/past_report.dart';

class PastReportTile extends StatelessWidget {
  final String date;
  final String condition;
  final double memoryScore;
  final List<EmotionData> emotions;
  final GlobalKey expansionTileKey;
  final Function scrollToPosition;

  const PastReportTile({
    super.key,
    required this.date,
    required this.condition,
    required this.memoryScore,
    required this.emotions,
    required this.expansionTileKey,
    required this.scrollToPosition,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: expansionTileKey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        date.substring(0, 10),
        style: const TextStyle(fontFamily: 'IBMPlexSansKRRegular'),
      ),
      collapsedBackgroundColor: Pallete.sodamReportPurple,
      backgroundColor: Pallete.sodamReportPurple,
      children: <Widget>[
        SizedBox(
          height: 300,
          child: SingleChildScrollView(
            child: PastReport(
              condition: condition,
              memoryScore: memoryScore,
              emotions: emotions,
            ),
          ),
        ),
      ],
      onExpansionChanged: (value) {
        if (value) {
          // Scroll to this tile when expanded
          scrollToPosition(expansionTileKey);
        }
      },
    );
  }
}
