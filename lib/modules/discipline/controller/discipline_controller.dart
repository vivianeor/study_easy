import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:study_easy/modules/discipline/model/discipline.dart';

class DisciplineController extends GetxController{
  var discipline = [].obs;

  var disciplineBox = Hive.box<Discipline>('discipline').obs;

  DisciplineController(){
    getItems();
  }

  getItems(){
    discipline.value = [];
    for (int i = 0; i < disciplineBox.value.values.length; i++){
      discipline.add(disciplineBox.value.getAt(i)!);
    }
  }

  addDiscipline(Discipline discipline1){
    disciplineBox.value.add(discipline1);
    getItems();
  }

  deleteDiscipline(Discipline discipline1){
    int index = discipline.indexOf(discipline1);
    disciplineBox.value.deleteAt(index);
    discipline.removeWhere((e) => e.id == discipline1.id);
    //calendar.refresh();
  }

  updateDiscipline(Discipline oldDiscipline, String newName,
      double? newN1, double? newN2, double? newN3){
    int index = discipline.indexOf(oldDiscipline);
    discipline[index].name = newName;
    discipline[index].nota1 = newN1;
    discipline[index].nota2 = newN2;
    discipline[index].nota3 = newN3;
    disciplineBox.value.putAt(index, discipline[index]);
    update();
  }

}