import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScoreWidget extends StatelessWidget {
  final int score;

  const ScoreWidget({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Text(
      score.toString(),
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: Colors.white.withOpacity(0.9),
        fontFamily: GoogleFonts.russoOne().fontFamily,
      ),
    );
  }
}