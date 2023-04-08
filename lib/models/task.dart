import 'package:hive/hive.dart';

part 'task.g.dart';

//TODO: Need to update taskID field.
@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String title;

  @HiveField(1)
  String notes;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  bool isCompleted;

  @HiveField(4)
  int color;

  Task(this.title, this.notes, this.date, this.isCompleted, this.color);
}
