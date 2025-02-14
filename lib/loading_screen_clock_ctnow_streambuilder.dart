import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final Color minuteHandColor;
  final Color secondHandColor;

  const LoadingScreen({
    super.key,
    this.minuteHandColor = Colors.blue,
    this.secondHandColor = Colors.red,
  });

  // Stream for updating time every second
  Stream<DateTime> get _clockStream => Stream.periodic(
    Duration(seconds: 1),
        (_) => DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: Colors.grey.withValues(alpha: 1)), // Lighter transparency
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Clock updates via StreamBuilder
              StreamBuilder<DateTime>(
                stream: _clockStream,
                initialData: DateTime.now(),
                builder: (context, snapshot) {
                  return SizedBox(
                    width: 100,
                    height: 100,
                    child: CustomPaint(
                      painter: AnalogClockPainter(
                        snapshot.data!,
                        minuteHandColor: minuteHandColor,
                        secondHandColor: secondHandColor,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(color: Colors.white, strokeWidth: 1),
              SizedBox(height: 10),
              Text(
                "Loading, please wait...",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Analog Clock Painter
class AnalogClockPainter extends CustomPainter {
  final DateTime time;
  final Color minuteHandColor;
  final Color secondHandColor;

  AnalogClockPainter(this.time, {required this.minuteHandColor, required this.secondHandColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paintCircle = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final paintBorder = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final paintMinuteHand = Paint()
      ..color = minuteHandColor
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final paintSecondHand = Paint()
      ..color = secondHandColor
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    // Draw clock background
    canvas.drawCircle(center, radius, paintCircle);
    canvas.drawCircle(center, radius, paintBorder);

    // Calculate hand positions
    final minuteAngle = (time.minute * 6) * (math.pi / 180);
    final minuteHand = Offset(
      center.dx + radius * 0.6 * math.cos(minuteAngle - math.pi / 2),
      center.dy + radius * 0.6 * math.sin(minuteAngle - math.pi / 2),
    );

    final secondAngle = (time.second * 6) * (math.pi / 180);
    final secondHand = Offset(
      center.dx + radius * 0.8 * math.cos(secondAngle - math.pi / 2),
      center.dy + radius * 0.8 * math.sin(secondAngle - math.pi / 2),
    );

    // Draw hands
    canvas.drawLine(center, minuteHand, paintMinuteHand);
    canvas.drawLine(center, secondHand, paintSecondHand);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
