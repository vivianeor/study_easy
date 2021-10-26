import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'todo.g.dart';

@HiveType(typeId: 2)
class Todo extends HiveObject{
  @HiveField(0)
  String id;
  @HiveField(1)
  late String title;
  @HiveField(2)
  bool? isCompleted;
  @HiveField(3)
  String? priority;
  Todo({required this.title, this.priority, this.isCompleted = false}):this.id=Uuid().v1();
}
