import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 3)
class TodoModel {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime dateTime;

  @HiveField(3)
  int status;

  @HiveField(4)
  int priority; // 1->high   2-> medium   3->low

  TodoModel({
    required this.title,
    required this.description,
    required this.dateTime,
    required this.status,
    required this.priority,
  });
}
