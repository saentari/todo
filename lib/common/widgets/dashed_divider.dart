import 'package:flutter/material.dart';

class DashedDivider extends StatelessWidget {
  final double height;
  final Color color;
  final double dashWidth;
  final double dashGap;
  final double indent;

  const DashedDivider({
    super.key,
    this.height = 1.0,
    this.color = const Color(0xFFD7D7D7),
    this.dashWidth = 4.0,
    this.dashGap = 4.0,
    this.indent = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: indent),
      child: CustomPaint(
        size: Size.fromHeight(height),
        painter: DashedLinePainter(color: color, height: height, dashWidth: dashWidth, dashGap: dashGap),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double height;
  final double dashWidth;
  final double dashGap;

  DashedLinePainter({required this.color, required this.height, this.dashWidth = 5.0, this.dashGap = 3.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = height
      ..style = PaintingStyle.stroke;

    double startX = 0;
    double endX = size.width;
    double currentX = startX;

    while (currentX < endX) {
      canvas.drawLine(Offset(currentX, 0), Offset(currentX + dashWidth, 0), paint);
      currentX += dashWidth + dashGap;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
