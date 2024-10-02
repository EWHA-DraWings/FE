import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:sodam/models/emotion_data.dart';
import 'package:sodam/screens/report/widget/build_emotion_row_widget.dart';

class DoughnutChartWidget extends StatefulWidget {
  final List<EmotionData> emotions;
  final double doughnutSize;
  final double doughnutWidth;
  final double boxWidth;
  final double offsetX;
  final double offsetY;
  final List<Color> colors;
  const DoughnutChartWidget(
      {super.key,
      required this.emotions,
      required this.doughnutSize,
      required this.doughnutWidth,
      required this.offsetX,
      required this.offsetY,
      required this.colors,
      required this.boxWidth});

  @override
  State<DoughnutChartWidget> createState() => _DoughnutChartWidgetState();
}

class _DoughnutChartWidgetState extends State<DoughnutChartWidget>
    with TickerProviderStateMixin {
  late AnimationController animationController;

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
              width: widget.boxWidth,
              height: 100,
              child: CustomPaint(
                size: const Size(120, 120),
                painter: _DoughnutChart(
                  animationController.value,
                  widget.emotions,
                  widget.doughnutSize,
                  widget.doughnutWidth,
                  widget.offsetX,
                  widget.offsetY,
                  widget.colors,
                ),
              ),
            ),
            Column(
              children: List.generate(widget.emotions.length, (index) {
                Color color;

                switch (index) {
                  case 0:
                    color = widget.colors[0];
                    break;
                  case 1:
                    color = widget.colors[1];
                    break;
                  case 2:
                    color = widget.colors[2];
                    break;
                  default:
                    color = Colors.grey;
                }

                return Column(
                  children: [
                    BuildEmotionRow(
                        emotion: widget.emotions[index].emotion, color: color),
                    if (index < widget.emotions.length - 1)
                      const SizedBox(height: 3),
                  ],
                );
              }),
            ),
          ],
        );
      },
    );
  }

  //차트 옆 색상-감정 위젯
}

class _DoughnutChart extends CustomPainter {
  final List<EmotionData> data;
  final double value; //애니메이션 값입니다. 0에서 1까지의 값으로, 애니메이션의 진행 상태
  final double radius; //원 반지름
  final double strokeWidth; //원 두께
  final double offsetX;
  final double offsetY;
  final List<Color> colors;

  _DoughnutChart(this.value, this.data, this.radius, this.strokeWidth,
      this.offsetX, this.offsetY, this.colors); //생성자로 초기화

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color.fromRGBO(61, 61, 61, 1);
    Offset offset = Offset(offsetX, offsetY); //차트의 위치를 결정

    paint.strokeWidth = strokeWidth;
    paint.style = PaintingStyle.stroke; //stroke : 원의 테두리만 그림
    paint.strokeCap = StrokeCap.round; //원의 끝모양을 둥글게
    double startPoint = 0.0;
    for (int i = 0; i < data.length; i++) {
      //원을 그리는 코드
      double count = data[i].percentage;
      count = (count * value + count) - data[i].percentage;
      double nextAngle = 2 * math.pi * (count / 100);
      paint.color = colors[i];
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
