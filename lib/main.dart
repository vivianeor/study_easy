import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'core/utils/const_colors.dart';
import 'core/utils/util_colors.dart';
import 'modules/calendar/controller/calendar_controller.dart';
import 'modules/calendar/model/calendar.dart';
import 'modules/discipline/controller/discipline_controller.dart';
import 'modules/discipline/model/discipline.dart';
import 'modules/home/home_page.dart';
import 'modules/notes/controller/note_controller.dart';
import 'modules/notes/model/note.dart';
import 'modules/todolist/controller/todo_controller.dart';
import 'modules/todolist/model/todo.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  Hive.registerAdapter<Calendar>(CalendarAdapter());
  await Hive.openBox<Calendar>('calendar');
  Hive.registerAdapter<Note>(NoteAdapter());
  await Hive.openBox<Note>('note');
  Hive.registerAdapter<Todo>(TodoAdapter());
  await Hive.openBox<Todo>('todo');
  Hive.registerAdapter<Discipline>(DisciplineAdapter());
  await Hive.openBox<Discipline>('discipline');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put<TodoController>(TodoController());
    Get.put<CalendarController>(CalendarController());
    Get.put<NoteController>(NoteController());
    Get.put<DisciplineController>(DisciplineController());
    return MaterialApp(
      title: 'Study Easy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: createMaterialColor(ConstColors.blue),
          accentColor: ConstColors.grey,
          scaffoldBackgroundColor: ConstColors.background,
          //  brightness: Brightness.dark,
          fontFamily: 'Nunito Regular',
          textSelectionTheme: TextSelectionThemeData(
              cursorColor: createMaterialColor(ConstColors.yellow),
              selectionColor: createMaterialColor(ConstColors.grey)
          )
      ),
      home: HomePage(),
    );
  }
}