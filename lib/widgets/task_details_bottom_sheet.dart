import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tweak_clone/data/tasksDB.dart';
import 'package:tweak_clone/models/task_colors.dart';
import 'package:tweak_clone/widgets/coming_soon.dart';
import 'package:tweak_clone/widgets/pick_color.dart';
import 'package:tweak_clone/widgets/promptDialog.dart';

import '../UI/colours.dart';
import '../models/task.dart';
import 'big_text.dart';

class TaskDetailsBottomSheet extends StatefulWidget {
  final Task task;
  final int id;

  const TaskDetailsBottomSheet(
      {super.key, required this.task, required this.id});

  @override
  State<TaskDetailsBottomSheet> createState() => _TaskDetailsBottomSheetState();
}

class _TaskDetailsBottomSheetState extends State<TaskDetailsBottomSheet> {
  final TasksDB _db = TasksDB();

  bool _isExpand = false;
  bool _isSelColor = false;

  // void refresh() {
  //   setState(() {
  //     widget.task = _db.getTask(widget.id);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Initializing controller for Note Field
    TextEditingController noteController = TextEditingController();
    if (widget.task.notes.isNotEmpty) noteController.text = widget.task.notes;

    // Initializing controller for title Field
    TextEditingController titleController = TextEditingController();
    if (widget.task.title.isNotEmpty) titleController.text = widget.task.title;

    // Initilizing the DB object
    TasksDB dataStore = TasksDB();

    return SingleChildScrollView(
      reverse: true,
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 5, right: 10, bottom: 10),
        decoration: BoxDecoration(
          // color: primaryBG,
          color: taskColors[widget.task.color],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: const Icon(Icons.calendar_month_outlined)),
                      GestureDetector(
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: widget.task.date,
                                  currentDate: widget.task.date,
                                  firstDate: DateTime(2020, 01, 01),
                                  lastDate: DateTime(2030, 12, 31),
                                  initialEntryMode:
                                      DatePickerEntryMode.calendarOnly)
                              .then((value) {
                            setState(() {
                              widget.task.date = value!;
                              _db.updateTask(widget.id, widget.task);
                            });
                          });

                          // DatePicker.showDatePicker(
                          //   context,
                          //   showTitleActions: true,
                          //   minTime: DateTime(2020,01,01),
                          //   maxTime: DateTime(2030,12,31),
                          //   currentTime: widget.task.date,
                          // );
                        },
                        child: BigText(
                          text: DateFormat("EEEE, MMM d yyyy")
                              .format(widget.task.date),
                          color: primaryFG,
                          size: 18,
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 1, right: 10),
                    child: (MediaQuery.of(context).viewInsets.bottom == 0.0)
                        ? IconButton(
                            icon: Icon(
                              Icons.close_rounded,
                              color: taskSecondaryColors[widget.task.color],
                            ),
                            onPressed: (() => Navigator.of(context).pop()),
                          )
                        : GestureDetector(
                            child: Text(
                              "Save",
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: primaryFG),
                            ),
                            onTap: () {
                              // TODO: Implement the onclick method.
                              widget.task.notes = noteController.text;
                              if (titleController.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Task can't be blank");
                              } else {
                                widget.task.title = titleController.text;
                              }
                              dataStore.updateTask(widget.id, widget.task);
                              Navigator.pop(context);
                            },
                          ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 0, left: 20),
              // child: BigText(
              //   text: task.title,
              //   color: primaryFG,
              //   size: 28,
              // )
              child: TextField(
                controller: titleController,
                onSubmitted: (value) {
                  if (titleController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Task can't be blank");
                  } else {
                    widget.task.title = titleController.text;
                  }
                },
                style: GoogleFonts.roboto(
                    fontSize: 28, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            Container(
              height: (_isExpand) ? 450 : 200,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: noteController,
                maxLines: 10,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Add some extra notes here",
                  hintStyle:
                      GoogleFonts.roboto(fontSize: 16, color: taskSecondaryColors[widget.task.color]),
                ),
              ),
            ),

            // This is to accomodate the keyboard whenever appears.
            if (_isExpand == false)
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom)),

            if (_isSelColor)
              PickColor(
                task: widget.task,
                id: widget.id,
                // func: refresh,
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // TODO: Implement the functionalities for each button.
                IconButton(
                    icon: const Icon(Icons.delete_outline, color: primaryFG),
                    onPressed: () {
                      showDialog(
                        // barrierColor: Colors.transparent,
                        context: context,
                        builder: ((context) {
                          return PromptDialog(id: widget.id);
                        }),
                      );
                    }),
                IconButton(
                  icon: const Icon(Icons.repeat),
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierColor: Colors.transparent,
                        builder: (context) {
                          return ComingSoon();
                        });
                  },
                ),

                IconButton(
                    icon: const Icon(Icons.circle_outlined),
                    onPressed: () {
                      setState(() {
                        _isExpand = !_isExpand;
                        _isSelColor = !_isSelColor;
                      });
                      // showDialog(
                      //     barrierColor: Colors.transparent,
                      //     context: context,
                      //     builder: ((context) {
                      //       return PickColor(task: widget.task);
                      //     }));
                    }),

                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierColor: Colors.transparent,
                        builder: (context) {
                          return ComingSoon();
                        });
                  },
                  icon: const Icon(Icons.notifications_outlined)
                ),

                IconButton(
                    onPressed: () {
                      widget.task.isCompleted = !widget.task.isCompleted;
                      dataStore.updateTask(widget.id, widget.task);
                      Navigator.pop(context);
                    },
                    icon: (widget.task.isCompleted)
                        ? const Icon(
                            Icons.check_circle,
                            color: secondaryFG,
                          )
                        : const Icon(Icons.check_circle_outline))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
