import 'package:calander/calander.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tweak_clone/UI/colours.dart';
import 'package:tweak_clone/UI/home_page.dart';

import '../widgets/big_text.dart';

class CalanderPage extends StatefulWidget {
  const CalanderPage({super.key});

  @override
  State<CalanderPage> createState() => _CalanderPageState();
}

class _CalanderPageState extends State<CalanderPage> {
  
  DateTime date = DateTime.now();
  int selYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryBG,
        appBar: AppBar(
          backgroundColor: primaryBG,
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Month and year
              GestureDetector(
                onTap: (selYear != DateTime.now().year) ? (){
                    setState(() {
                        selYear = DateTime.now().year;
                    });
                }:null,
                child: BigText(
                    text: selYear.toString(),
                    color: primaryFG),
              ),

              // Navigation Area
              Row(
                children: [
                  // User Icon
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

                  // Previous year Button
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
                        onPressed: () {
                          setState(() {
                            selYear = selYear - 1;
                          });
                        },
                      )),

                  // Next year Button
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
                        onPressed: () {
                          setState(() {
                            selYear = selYear + 1;
                          });
                        },
                      ))
                ],
              ),
            ],
          ),
          // */
        ),
        body: Column(
            children: [
                const SizedBox(height: 20,),
                Calander(
                    focusedDate: date,
                    year: selYear,
                    onDaySelect: (DateTime date){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage(date: date,))
                        );
                    },
                )
            ]
        )
    );
  }
}
