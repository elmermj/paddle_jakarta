import 'dart:math';
import 'package:flutter/material.dart';

class RadarChartWidget extends StatefulWidget {
  final List<double> values; // Six values for the radar chart
  final List<String> labels;
  final double height;

  const RadarChartWidget({
    Key? key,
    required this.values,
    required this.labels,
    required this.height,
  }) : super(key: key);

  @override
  _RadarChartWidgetState createState() => _RadarChartWidgetState();
}

class _RadarChartWidgetState extends State<RadarChartWidget>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;
  final List<double> _animatedValues = [];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.values.length, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 900),
      );
    });

    _animations = List.generate(widget.values.length, (index) {
      final tween = TweenSequence<double>([
        TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 50),
        TweenSequenceItem(
            tween: Tween(begin: 1.0, end: widget.values[index]), weight: 50),
      ]);
      return tween.animate(CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.easeInOut,
      ));
    });

    // Initialize animated values
    _animatedValues.addAll(List.filled(widget.values.length, 0.0));

    _startAnimations();
  }

  void _startAnimations() {
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: 100 * i), () {
        _controllers[i].forward();
        _controllers[i].addListener(() {
          setState(() {
            _animatedValues[i] = _animations[i].value;
          });
        });
      });
    }
    // Future.delayed(
    //   Duration(milliseconds: 600 + (200 * _controllers.length)),
    //   () {
    //     for (var controller in _controllers) {
    //       controller.reverse();
    //       controller.forward();
    //     }
    //   }
    // );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0), // Add padding to prevent clipping
      child: CustomPaint(
        painter: RadarChartPainter(
          values: _animatedValues,
          labels: widget.labels,
          color: Theme.of(context).colorScheme.onPrimary
        ),
        size: Size(MediaQuery.sizeOf(context).width -24, widget.height -48), // Set size explicitly
      ),
    );
  }
}

class RadarChartPainter extends CustomPainter {
  final List<double> values;
  final List<String> labels;
  final Color color;

  RadarChartPainter({
    required this.values,
    required this.labels,
    required this.color
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint gridPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke;

    final Paint dataPaint = Paint()
      ..color = Colors.blue.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = min(centerX, centerY) * 0.7; // Adjusted to leave space for labels
    final int numVariables = values.length;
    final double angleStep = 2 * pi / numVariables;

    // Draw grid
    for (int i = 1; i <= 5; i++) {
      double currentRadius = (radius / 5) * i;
      drawPolygon(canvas, centerX, centerY, currentRadius, numVariables, gridPaint);
    }

    // Draw data
    Path dataPath = Path();
    for (int i = 0; i < numVariables; i++) {
      double scaledValue = values[i];
      double x = centerX + scaledValue * radius * cos(i * angleStep - pi / 2);
      double y = centerY + scaledValue * radius * sin(i * angleStep - pi / 2);
      if (i == 0) {
        dataPath.moveTo(x, y);
      } else {
        dataPath.lineTo(x, y);
      }
    }
    dataPath.close();
    canvas.drawPath(dataPath, dataPaint);

    // Draw labels
    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < numVariables; i++) {
      // Calculate label position with padding
      double x = centerX + (radius + (i==0 || i==3? 10 : 20)) * cos(i * angleStep - pi / 2);
      double y = centerY + (radius + (i==0 || i==3? 10 : 20)) * sin(i * angleStep - pi / 2);

      textPainter.text = TextSpan(
        text: labels[i],
        style: TextStyle(color: color, fontSize: 10),
      );
      textPainter.layout();

      final double dx = x - textPainter.width / 2;
      final double dy = y - textPainter.height / 2;

      textPainter.paint(canvas, Offset(dx, dy));
    }
  }

  void drawPolygon(Canvas canvas, double centerX, double centerY, double radius,
      int sides, Paint paint) {
    Path path = Path();
    for (int i = 0; i <= sides; i++) {
      double angle = (2 * pi * i / sides) - pi / 2;
      double x = centerX + radius * cos(angle);
      double y = centerY + radius * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}