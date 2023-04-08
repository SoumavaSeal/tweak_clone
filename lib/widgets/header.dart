import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tweak_clone/UI/colours.dart';

import 'big_text.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Month and year
        BigText(
            text: DateFormat("MMM yyyy").format(DateTime.now()),
            color: primaryFG),

        // Navigation Area
        Row(
          children: [
            // User Icons
            Container(
                height: 48,
                width: 48,
                margin: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: secondaryBG,
                ),
                child: Center(
                    child: Text("S",
                        style: GoogleFonts.roboto(
                            fontSize: 32,
                            color: primaryBG,
                            fontWeight: FontWeight.w400)))),

            // Previous week Button
            Container(
                height: 32,
                width: 32,
                margin: const EdgeInsets.only(left: 5, right: 5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryFG,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                  iconSize: 20,
                  onPressed: () {},
                )),

            // Next Week Button
            Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryFG,
                ),
                child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                    iconSize: 20,
                    onPressed: () {}))
          ],
        ),
      ],
    );
  }
}
