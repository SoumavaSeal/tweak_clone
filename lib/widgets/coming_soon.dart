import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tweak_clone/UI/colours.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.topCenter,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
            color: primaryFG,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "Coming Soon",
            // textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryBG,
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: secondaryFG,
                size: 32,
              ))
        ]),
      ),
    );
  }
}
