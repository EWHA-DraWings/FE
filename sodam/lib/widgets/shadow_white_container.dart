import 'package:flutter/material.dart';

class ShadowWhiteContainer extends StatelessWidget {
  final double height;
  final String title;
  final Widget child;
  final bool isRight; //text가 오른쪽에 놓이면 true

  const ShadowWhiteContainer({
    super.key,
    required this.title,
    required this.child,
    required this.height,
    required this.isRight,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'IBMPlexSansKRBold',
                fontSize: 25,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 10,
            ),
            isRight
                ? Align(
                    alignment:
                        Alignment.centerRight, // Align the child to the right
                    child: child,
                  )
                : child,
          ],
        ),
      ),
    );
  }
}
