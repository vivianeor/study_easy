import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'discipline.g.dart';

@HiveType(typeId: 4)
class Discipline extends HiveObject{
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(5)
  double? nota1;
  @HiveField(6)
  double? nota2;
  @HiveField(7)
  double? nota3;
//5, 6, 7
  Discipline({
    required this.name,
    this.nota1,
    this.nota2,
    this.nota3
  }):this.id=Uuid().v1();

  String toString() => this.name;
}
