import 'package:hive/hive.dart';

part 'todo_item.g.dart';

@HiveType(typeId: 0)
class TodoItem {
  TodoItem({
    required this.timeStamp,
    required this.description,
    this.isComplete = false,
  });

  @HiveField(0)
  int timeStamp;
  @HiveField(1)
  String description;
  @HiveField(2)
  bool isComplete;
}
