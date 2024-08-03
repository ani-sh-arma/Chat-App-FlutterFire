import 'package:flutter/material.dart';

class SliderContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.1059948);
    path_0.cubicTo(0, size.height * 0.04664227, size.width * 0.04342388, size.height * -0.0004519656, size.width * 0.09488925, size.height * 0.003085165);
    path_0.lineTo(size.width * 0.9157851, size.height * 0.05950412);
    path_0.cubicTo(size.width * 0.9630866, size.height * 0.06275498, size.width, size.height * 0.1078632, size.width, size.height * 0.1624137);
    path_0.lineTo(size.width, size.height * 0.7319588);
    path_0.cubicTo(size.width, size.height * 0.7888969, size.width * 0.9599075, size.height * 0.8350515, size.width * 0.9104478, size.height * 0.8350515);
    path_0.lineTo(size.width * 0.7414418, size.height * 0.8350515);
    path_0.cubicTo(size.width * 0.6914090, size.height * 0.8350515, size.width * 0.6452627, size.height * 0.8661134, size.width * 0.6207224, size.height * 0.9163058);
    path_0.cubicTo(size.width * 0.5677522, size.height * 1.024649, size.width * 0.4322478, size.height * 1.024649, size.width * 0.3792776, size.height * 0.9163058);
    path_0.cubicTo(size.width * 0.3547373, size.height * 0.8661134, size.width * 0.3085910, size.height * 0.8350515, size.width * 0.2585570, size.height * 0.8350515);
    path_0.lineTo(size.width * 0.08955224, size.height * 0.8350515);
    path_0.cubicTo(size.width * 0.04009403, size.height * 0.8350515, 0, size.height * 0.7888969, 0, size.height * 0.7319588);
    path_0.lineTo(0, size.height * 0.1059948);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
