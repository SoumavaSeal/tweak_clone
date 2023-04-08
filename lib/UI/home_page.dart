import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tweak_clone/UI/colours.dart';
import 'package:tweak_clone/models/week_dates.dart';
import 'package:tweak_clone/widgets/task_list.dart';

import '../widgets/big_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeekDates wk = WeekDates();
  List<DateTime> week = [];

  @override
  void initState() {
    week = wk.generateDates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryBG,
        appBar: AppBar(
          backgroundColor: primaryBG,
          elevation: 0.0,
          // title: const Header(),

          //TODO: find a way to seperate the contents of the header widget into a differenr file.
          /* Contents of the Header Widget*/
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Month and year
              BigText(
                  text: DateFormat("MMM yyyy").format(DateTime.now()),
                  color: primaryFG),

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
                        onPressed: () {
                          setState(() {
                            week = wk.PrevDates(week[0]);
                          });
                        },
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
                        onPressed: () {
                          setState(() {
                            week = wk.NextDates(week[0]);
                          });
                        },
                      ))
                ],
              ),
            ],
          ),
          // */
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            padding: const EdgeInsets.only(left: 15, right: 15),
            // child: TaskList(date: week[0], taskList: taskList,),
            child: ListView.builder(
                itemCount: 7,
                itemBuilder: ((context, index) {
                  return TaskList(date: week[index]);
                })),
          ),
        ));
  }
}
