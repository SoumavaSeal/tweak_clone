import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tweak_clone/UI/colours.dart';
import 'package:tweak_clone/data/tasksDB.dart';
import 'package:tweak_clone/models/constants.dart';


class PromptDialog extends StatelessWidget {
  final int id;
  const PromptDialog({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    TasksDB dataStore = TasksDB();

    return Dialog(
        alignment: Alignment.center,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        backgroundColor: Colors.transparent,
        child: Container(
          height: 250,
          padding:
              const EdgeInsets.only(top: 40, left: 20, right: 10, bottom: 20),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: promptBG),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 15),
                  child: Text("Delete a Task ?",
                      style: GoogleFonts.roboto(
                          fontSize: 20, fontWeight: FontWeight.bold))),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 25),
                child: Text(
                  deleteTakPromptMessege,
                  style: GoogleFonts.lato(
                    fontSize: 16,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: negBG,
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                        ),
                        child: const Text("No, Cancel")),
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                        onPressed: () {
                          dataStore.removeTask(id);
                          Fluttertoast.showToast(msg: "Successfully Deleted");
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: posBG,
                          foregroundColor: primaryFG,
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1.0),
                              borderRadius: BorderRadius.circular(25.0)),
                        ),
                        child: const Text("Yes, Please")),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
