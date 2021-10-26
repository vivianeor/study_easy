import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:study_easy/modules/calendar/model/calendar.dart';

class CalendarController extends GetxController{
  var calendar = [].obs;

  var calendarBox = Hive.box<Calendar>('calendar').obs;

  CalendarController(){
   getItems();
  }

  getItems(){
    calendar.value = [];
    for (int i = 0; i < calendarBox.value.values.length; i++){
      calendar.sort((a,b) => a.date.compareTo(b.date));
      calendar.add(calendarBox.value.getAt(i)!);
    }
  }

  addCalendar(Calendar calendar1){
    calendarBox.value.add(calendar1);
    getItems();
  }

  deleteCalendar(Calendar calendar1){
    int index = calendar.indexOf(calendar1);
    calendarBox.value.deleteAt(index);
    calendar.removeWhere((e) => e.id == calendar1.id);
    //calendar.refresh();
  }

  updateCalendar(Calendar oldCalendar, String newName){
    int index = calendar.indexOf(oldCalendar);
    calendar[index].name = newName;
    calendarBox.value.putAt(index, calendar[index]);
  }

}