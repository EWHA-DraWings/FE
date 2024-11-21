import 'package:flutter/material.dart';
import 'package:sodam/models/report_data.dart';
import 'package:sodam/screens/report/widget/past_report_tile.dart';

class PastReportsList extends StatelessWidget {
  final Function scrollToPosition;
  final List<ReportData> pastReports;

  const PastReportsList({
    super.key,
    required this.scrollToPosition,
    required this.pastReports,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pastReports.length, //pastReports 리스트의 개수
      itemBuilder: (context, index) {
        final pastReport = pastReports[index];

        //각 pastReport에 대한 ExpansionTile을 생성
        return Row(
          children: [
            PastReportTile(
              date: pastReport.date,
              condition: pastReport.condition,
              memoryScore: pastReport.correctRatio,
              emotions: pastReport.emotions,
              expansionTileKey: GlobalKey(), //각 타일마다 고유한 키를 사용
              scrollToPosition: scrollToPosition,
            ),
          ],
        );
      },
    );
  }
}
