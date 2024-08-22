import 'package:flutter/material.dart';

class TrapezoidalPainter extends CustomPainter {
  final bool isLeft;

  TrapezoidalPainter({required this.isLeft});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final Path path = Path();

    if (isLeft) {
      path
        ..moveTo(0, size.height)
        ..lineTo(size.width * 0.8, size.height)
        ..lineTo(size.width, size.height * 0.3)
        ..lineTo(0, size.height * 0.3)
        ..close();
    } else {
      path
        ..moveTo(size.width * 0.2, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, size.height * 0.7)
        ..lineTo(size.width * 0.2, size.height)
        ..close();
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class TrapezoidClipper extends CustomClipper<Path> {

  TrapezoidClipper();

  @override
  Path getClip(Size size) {
    final Path path = Path();

    // if (isLeft) {
      path
        ..moveTo(0, size.height)
        ..lineTo(size.width * 0.8, size.height)
        ..lineTo(size.width, size.height * 0.3)
        ..lineTo(0, size.height * 0.3)
        ..close();
    // } else {
    //   path
    //     ..moveTo(size.width * 0.2, 0)
    //     ..lineTo(size.width, 0)
    //     ..lineTo(size.width, size.height * 0.7)
    //     ..lineTo(size.width * 0.2, size.height)
    //     ..close();
    // }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


class TrapezoidalWidget extends StatelessWidget {
  final bool isLeft;
  final double aspectRatio;
  final ImageProvider? image;

  const TrapezoidalWidget({
    super.key,
    required this.isLeft, required this.aspectRatio, this.image,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ClipPath(
        clipper: TrapezoidClipper(),
        child: Container(
          decoration: BoxDecoration(
            image: image != null ? DecorationImage(image: image!, fit: BoxFit.cover) : null,
            gradient: isLeft 
          ? LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Colors.black.withOpacity(0.25),
                Theme.of(context).colorScheme.primary.withOpacity(0.8), 
              ],
            )
          : LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.red.withOpacity(0.8),
                Colors.black.withOpacity(0.25),
              ],
            ),
          ),
          // CustomPaint(
          //   painter: TrapezoidalPainter(isLeft: isLeft),
          // ),
        ),
      ),
    );
  }
}
