import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tweak_clone/UI/colours.dart';
import 'package:tweak_clone/data/tasksDB.dart';
import 'package:tweak_clone/models/task.dart';
import 'package:tweak_clone/widgets/big_text.dart';
import 'package:tweak_clone/widgets/task_tile.dart';

class TaskList extends StatefulWidget {
  final DateTime date;

  const TaskList({super.key, required this.date});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  TasksDB dataStore = TasksDB();
  DateTime curDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: [
          // Heading Area
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BigText(
                text: DateFormat("MMM d").format(widget.date),
                color: (curDate == widget.date) ? primaryHeading : primaryFG,
                size: 28,
              ),
              BigText(
                text: DateFormat("E").format(widget.date),
                color: (curDate == widget.date) ? secondaryHeading : secondaryFG,
                size: 24,
              ),
            ],
          ),

          // Seperator
          Container(
            height: 2,
            width: size.width * 0.95,
            decoration: BoxDecoration(
              color: (curDate == widget.date) ? primaryHeading : primaryFG
            ),
          ),

          // Tasklist
          ValueListenableBuilder(
              valueListenable: dataStore.listen(),
              builder: ((context, Box<Task> tasks, _) {
                List<int> keys;

                keys = tasks.keys
                    .cast<int>()
                    .where((key) => (tasks.get(key)!.date == widget.date))
                    .toList();

                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: keys.length,
                    shrinkWrap: true,
                    itemBuilder: ((_, index) {
                      return TaskTile(
                          task: tasks.get(keys[index]),
                          id: keys[index],
                          date: widget.date);
                    }));
              })),

          // Input Field
          Container(
              width: size.width * 0.9,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextField(
                controller: taskController,
                onSubmitted: (value) {
                  setState(() {
                    DateTime dt = DateTime(
                        widget.date.year, widget.date.month, widget.date.day);
                    Task newTask = Task(value, "", dt, false, 0);

                    if (taskController.text.isNotEmpty) {
                      // tasks.add(newTask);
                      dataStore.addTask(newTask);
                      Fluttertoast.showToast(msg: "Task Added Successfully");
                    } else {
                      Fluttertoast.showToast(msg: "Task can't be blank");
                    }
                    taskController.clear();
                  });
                },
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 2.0, color: secondaryFG)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 2.0, color: secondaryFG)),
                ),
              ))
        ],
      ),
    );
  }
}
