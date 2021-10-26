import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  late String title;
  @HiveField(2)
  late String text;
  @HiveField(3)
  late String titleFolder;

  Note({required this.title, required this.text, required this.titleFolder}):this.id=Uuid().v1();
}