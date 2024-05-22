import 'package:flutter/material.dart';
import 'dart:math' as math;

const String heart = 'assets/images/heart-alt.png';
const String knife = 'assets/images/knife.png';
const String speed = 'assets/images/speed.png';

class AttributeWidget extends StatefulWidget {
  final double size;
  final double progress;
  final Widget child;

  const AttributeWidget({
    super.key,
    required this.progress,
    this.size = 42,
    required this.child,
  });

  @override
  State<AttributeWidget> createState() => _AttributeWidgetState();
}

class _AttributeWidgetState extends State<AttributeWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: AttributePainter(
        progressPercent: widget.progress,
      ),
      size: Size(widget.size, widget.size),
      child: Container(
        padding: EdgeInsets.all(widget.size / 3.8),
        width: widget.size,
        height: widget.size,
        child: widget.child,
      ),
    );
  }
}

class AttributePainter extends CustomPainter {
  final double progressPercent;
  final double strokeWidth, filledStrokeWidth;

  // ignore: prefer_typing_uninitialized_variables
  final bgPaint, strokeBgPaint, strokeFilledPaint;

  AttributePainter({
    required this.progressPercent,
    this.strokeWidth = 2.0,
    this.filledStrokeWidth = 4.0,
  })  : bgPaint = Paint()..color = Colors.white.withOpacity(0.25),
        strokeBgPaint = Paint()..color = Color(0xffD264C9),
        strokeFilledPaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = filledStrokeWidth
          ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawCircle(center, radius, bgPaint);
    canvas.drawCircle(center, radius - strokeWidth, strokeBgPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - (strokeWidth / 2)),
      -math.pi / 2, // - 45 degrees to start from top
      (progressPercent / 100) * math.pi * 2,
      false,
      strokeFilledPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
