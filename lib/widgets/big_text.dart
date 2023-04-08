import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BigText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;

  const BigText(
      {super.key, required this.text, required this.color, this.size = 36.0});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
          color: color, fontSize: size, fontWeight: FontWeight.bold),
    );
  }
}
