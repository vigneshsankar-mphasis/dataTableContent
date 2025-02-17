import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  final Color hourHandColor;
  final Color minuteHandColor;
  final Color secondHandColor;
  final Color backgroundColor;
  final String loadingText;

  const LoadingScreen({
    super.key,
    this.hourHandColor = Colors.black,
    this.minuteHandColor = Colors.blue,
    this.secondHandColor = Colors.red,
    this.backgroundColor = Colors.grey,
    this.loadingText = "Loading, please wait...",
  });

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  late Timer _timer;
  DateTime currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    try {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          currentTime = DateTime.now();
        });
      });
    } catch (e) {
      debugPrint("Error in initState: $e");
    }
  }

  @override
  void dispose() {
    try {
      _timer.cancel();
    } catch (e) {
      debugPrint("Error in dispose: $e");
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      double clockSize = MediaQuery.of(context).size.width < 400 ? 75 : 100;
      return Stack(
        fit: StackFit.expand,
        children: [
          Container(color: widget.backgroundColor.withOpacity(1)),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: clockSize,
                  height: clockSize,
                  child: CustomPaint(
                    painter: AnalogClockPainter(
                      currentTime,
                      hourHandColor: widget.hourHandColor,
                      minuteHandColor: widget.minuteHandColor,
                      secondHandColor: widget.secondHandColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(color: Colors.white, strokeWidth: 1),
                const SizedBox(height: 10),
                Text(
                  widget.loadingText,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      );
    } catch (e) {
      debugPrint("Error in build method: $e");
      return Center(
        child: Text(
          "Error loading screen.",
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
      );
    }
  }
}

class AnalogClockPainter extends CustomPainter {
  final DateTime time;
  final Color hourHandColor;
  final Color minuteHandColor;
  final Color secondHandColor;

  AnalogClockPainter(this.time, {required this.hourHandColor, required this.minuteHandColor, required this.secondHandColor});

  @override
  void paint(Canvas canvas, Size size) {
    try {
      final center = Offset(size.width / 2, size.height / 2);
      final radius = size.width / 2;

      final paintCircle = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;

      final paintBorder = Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;

      final paintHourHand = Paint()
        ..color = hourHandColor
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round;

      final paintMinuteHand = Paint()
        ..color = minuteHandColor
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round;

      final paintSecondHand = Paint()
        ..color = secondHandColor
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round;

      canvas.drawCircle(center, radius, paintCircle);
      canvas.drawCircle(center, radius, paintBorder);

      final hourAngle = ((time.hour % 12) * 30 + time.minute * 0.5) * (math.pi / 180);
      final hourHand = Offset(
        center.dx + radius * 0.5 * math.cos(hourAngle - math.pi / 2),
        center.dy + radius * 0.5 * math.sin(hourAngle - math.pi / 2),
      );

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

      canvas.drawLine(center, hourHand, paintHourHand);
      canvas.drawLine(center, minuteHand, paintMinuteHand);
      canvas.drawLine(center, secondHand, paintSecondHand);
    } catch (e) {
      debugPrint("Error in AnalogClockPainter.paint: $e");
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
