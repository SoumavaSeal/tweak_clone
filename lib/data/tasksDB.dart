import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tweak_clone/models/task.dart';

class TasksDB {
  final _taskBox = Hive.box<Task>("TASK_BOX");

  List<Task> loadTasks(DateTime date) {
    var allTasks = _taskBox.values;

    List<Task> tasks = allTasks.where((task) => (task.date == date)).toList();

    return tasks;
  }

  void updateTask(int key, Task task) {
    _taskBox.put(key, task);
  }

  void addTask(Task task) {
    _taskBox.add(task);
  }

  void removeTask(int key) {
    _taskBox.delete(key);
  }

  getTask(int key) {
    return _taskBox.getAt(key);
  }

  // final _taskBox = Hive.box<Task>("tasks_box");

  // List<Task> loadData(DateTime date) {
  //   return _taskBox.values.where((task) => (task.date == date)).toList();
  // }

  // void addTask(Task task) {
  //   _taskBox.add(task);
  // }

  ValueListenable<Box<Task>> listen() {
    return _taskBox.listenable();
  }
}
