import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tweak_clone/data/tasksDB.dart';
import 'package:tweak_clone/models/task_colors.dart';
import 'package:tweak_clone/widgets/task_details_bottom_sheet.dart';

import '../UI/colours.dart';

class TaskTile extends StatefulWidget {
  final int id;
  final task;
  final DateTime date;

  const TaskTile(
      {super.key, required this.task, required this.id, required this.date});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  TasksDB dataStore = TasksDB();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: ((context) => TaskDetailsBottomSheet(
              task: widget.task, id: widget.id))),
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        width: size.width * 0.9,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.task.title,
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      backgroundColor: taskColors[widget.task.color],
                      color:
                          (widget.task.isCompleted) ? taskSecondaryColors[widget.task.color] : primaryFG,
                      decorationColor: (widget.task.isCompleted) ? secondaryFG : primaryFG,
                      decoration: (widget.task.isCompleted)
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  IconButton(
                      icon: (widget.task.isCompleted)
                          ? const Icon(
                              Icons.check_circle,
                              color: secondaryFG,
                            )
                          : const Icon(Icons.check_circle_outline),
                      onPressed: () {
                        setState(() {
                          widget.task.isCompleted = !widget.task.isCompleted;
                          dataStore.updateTask(widget.id, widget.task);
                        });
                      })
                ],
              ),
            ),
            Container(
              height: 1.0,
              width: size.width * 0.9,
              decoration: const BoxDecoration(color: secondaryFG),
            )
          ],
        ),
      ),
    );
  }
}
