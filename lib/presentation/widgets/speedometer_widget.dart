import 'package:flutter/material.dart';
import 'dart:math';

import 'package:google_fonts/google_fonts.dart';

class SpeedometerWidget extends StatefulWidget {
  final double actualValue;
  final double height;
  final MediaQueryData mediaQuery;

  const SpeedometerWidget({Key? key, required this.actualValue, required this.mediaQuery, required this.height}) : super(key: key);

  @override
  State<SpeedometerWidget> createState() => _SpeedometerWidgetState();
}

class _SpeedometerWidgetState extends State<SpeedometerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Define animation sequence
    _animation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 100.0).chain(CurveTween(curve: Curves.easeOut)),
        weight: 1.0,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 100.0, end: widget.actualValue).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1.0,
      ),
    ]).animate(_controller);

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: AspectRatio(
        aspectRatio: 18/9,
        child: Center(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomPaint(
                      size: Size(widget.height, widget.height),
                      painter: SpeedometerPainter(_animation.value, Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter.add(const AlignmentDirectional(0.25, 0)),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "You're in top "+_animation.value.toStringAsFixed(1) + "%",
                                style: TextStyle(
                                  fontSize: 14, 
                                  fontWeight: FontWeight.bold, 
                                  fontFamily: GoogleFonts.russoOne().fontFamily,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Rank 688 out of 1000',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: GoogleFonts.russoOne().fontFamily,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class SpeedometerPainter extends CustomPainter {
  final double value; // Current progress (0 to 100)
  final Color color;

  SpeedometerPainter(this.value, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw background arc
    final arcPaint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 20),
      pi / 2,
      3 * pi / 2,
      false,
      arcPaint,
    );

    // Break the foreground arc into segments for dynamic stroke width and opacity
    const int segments = 600;
    final double segmentSweep = (3 * pi / 2) / segments;

    for (int i = 0; i < segments; i++) {
      double segmentOpacity = 0.1 + (0.75 - 0.1) * (i / segments);
      double segmentStrokeWidth = 0.5 + (5.0 - 0.5) * (i / segments);

      if (i / segments > value / 100) {
        break;
      }

      final segmentPaint = Paint()
        ..color = color.withOpacity(segmentOpacity)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = segmentStrokeWidth;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - 20),
        pi / 2 + segmentSweep * i,
        segmentSweep,
        false,
        segmentPaint,
      );
    }

    // Draw numbers along the arc with dynamic opacity
    const int numberOfMarks = 11; // 0, 10, ..., 100
    final double numberSweep = (3 * pi / 2) / (numberOfMarks - 1);

    for (int i = 0; i < numberOfMarks; i++) {
      double angle = pi / 2 + numberSweep * i;
      String number = (i * 10).toString();

      // Determine if the number should be lit or dimmed
      double numberPercentage = i * 10; // Corresponding percentage for the number
      double opacity = (value >= numberPercentage) ? 1.0 : 0.3; // Full opacity if progress is above, dim otherwise

      // Calculate position for the number
      final textPainter = TextPainter(
        text: TextSpan(
          text: number,
          style: TextStyle(
            color: color.withOpacity(opacity), 
            fontSize: 10,
            fontFamily: GoogleFonts.russoOne().fontFamily
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final numberRadius = radius - 30; // Slightly inside the arc
      final textOffset = Offset(
        center.dx + numberRadius * cos(angle) - textPainter.width / 2,
        center.dy + numberRadius * sin(angle) - textPainter.height / 2,
      );

      textPainter.paint(canvas, textOffset);
    }

    // Draw the hand
    final handPaint = Paint()
      ..color = Colors.transparent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    final handLength = radius - 20;
    final handAngle = pi / 2 + (3 * pi / 2) * (value / 100);

    // Hand end point
    final handEnd = Offset(
      center.dx + handLength * cos(handAngle),
      center.dy + handLength * sin(handAngle),
    );

    // Ambient light effect
    final ambientPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withOpacity(0.75),
          Colors.transparent
        ],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: handEnd, radius: 12));

    canvas.drawCircle(handEnd, 15, ambientPaint);

    // Draw hand line
    canvas.drawLine(center, handEnd, handPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}