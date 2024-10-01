import 'package:flutter/material.dart';
import 'dart:math' as math;

class DoughnutChartWidget extends StatefulWidget {
  const DoughnutChartWidget({super.key});

  @override
  State<DoughnutChartWidget> createState() => _DoughnutChartWidgetState();
}

class _DoughnutChartWidgetState extends State<DoughnutChartWidget>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  List<PieModel> data = [
    PieModel(count: 60, color: Colors.amber),
    PieModel(count: 25, color: Colors.red),
    PieModel(count: 15, color: const Color(0xffAD00FF)),
  ];
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        if (animationController.value < 0.1) {
          return const SizedBox();
        }
        return Row(
          children: [
            SizedBox(
              width: 135,
              height: 100,
              child: CustomPaint(
                size: const Size(150, 150),
                painter: _DoughnutChart(data, animationController.value),
              ),
            ),
            Column(
              children: [
                _buildEmotionRow("당황", Colors.amber),
                const SizedBox(height: 3),
                _buildEmotionRow("슬픔", Colors.red),
                const SizedBox(height: 3),
                _buildEmotionRow("행복", const Color(0xffAD00FF)),
              ],
            ),
          ],
        );
      },
    );
  }
  //차트 옆 색상-감정 위젯
  Widget _buildEmotionRow(String emotion, Color color) {
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

class _DoughnutChart extends CustomPainter {
  final List<PieModel> data;
  final double value; //애니메이션 값입니다. 0에서 1까지의 값으로, 애니메이션의 진행 상태
  _DoughnutChart(this.data, this.value); //생성자로 초기화

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color.fromRGBO(61, 61, 61, 1);
    Offset offset = const Offset(60, 65); //차트의 위치를 결정
    double radius = 37; //?

    paint.strokeWidth = 22;
    paint.style = PaintingStyle.stroke; //stroke : 원의 테두리만 그림
    paint.strokeCap = StrokeCap.round; //원의 끝모양을 둥글게
    double startPoint = 0.0;
    for (int i = 0; i < data.length; i++) {
      //원을 그리는 코드
      double count = data[i].count.toDouble();
      count = (count * value + count) - data[i].count;
      double nextAngle = 2 * math.pi * (count / 100);
      paint.color = data[i].color;
      canvas.drawArc(
        Rect.fromCircle(center: offset, radius: radius),
        -math.pi / 2 + startPoint,
        nextAngle,
        false,
        paint,
      );
      startPoint = startPoint + nextAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class PieModel {
  final int count;
  final Color color;

  PieModel({
    required this.count,
    required this.color,
  });
}
