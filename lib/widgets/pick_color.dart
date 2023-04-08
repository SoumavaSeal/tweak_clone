import 'package:flutter/material.dart';
import 'package:tweak_clone/UI/colours.dart';
import 'package:tweak_clone/data/tasksDB.dart';
import 'package:tweak_clone/models/task_colors.dart';

import '../models/task.dart';

class PickColor extends StatefulWidget {
  final Task task;
  final int id;

  const PickColor({super.key, required this.task, required this.id});

  // final Function() func;

  // const PickColor(
  //     {super.key, required this.task, required this.id, required this.func});

  @override
  State<PickColor> createState() => _PickColorState();
}

class _PickColorState extends State<PickColor> {
  final TasksDB _tasksDB = TasksDB();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 50,
        decoration: const BoxDecoration(
            color: test, borderRadius: BorderRadius.all(Radius.circular(10))),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: taskColors.length,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () {
                widget.task.color = index;
                _tasksDB.updateTask(widget.id, widget.task);
                Navigator.pop(context);
                // setState(() {
                //   widget.task.color = index;
                //   _tasksDB.updateTask(widget.id, widget.task);
                //   widget.func;
                //   // this.dispose();
                // });
              },
              child: Container(
                width: 30,
                decoration: BoxDecoration(
                    color: taskColors[index], shape: BoxShape.circle),
              ),
            );
          }),
          separatorBuilder: ((context, index) {
            return const SizedBox(
              width: 10,
            );
          }),
        ),
      ),
    );
  }
}
