import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'calendar.g.dart';

@HiveType(typeId: 0)
class Calendar extends HiveObject{
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  DateTime? date;
  @HiveField(3)
  String? nameDiscipline;
  Calendar({this.date, required this.name, this.nameDiscipline}):this.id=Uuid().v1();

  String toString() => this.name;
}
