import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:study_easy/core/utils/const_colors.dart';
import 'package:study_easy/modules/calendar/calendar_page.dart';
import 'package:study_easy/modules/discipline/discipline_page.dart';
import 'package:study_easy/modules/home/home_page.dart';
import 'package:study_easy/modules/notes/note_page.dart';
import 'package:study_easy/modules/todolist/todolist_page.dart';

class BottomNavigatorApp extends StatefulWidget {
  final bool disableNotesButton;
  final bool disableHomeButton;
  final bool disableCalendarButton;
  final bool disableToDoButton;
  final bool disableDisciplineButton;
  BottomNavigatorApp({
    this.disableCalendarButton = false,
    this.disableHomeButton = false,
    this.disableNotesButton = false,
    this.disableToDoButton = false,
    this.disableDisciplineButton = false,
  });
  @override
  _BottomNavigatorAppState createState() => _BottomNavigatorAppState();
}

class _BottomNavigatorAppState extends State<BottomNavigatorApp> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ConstColors.background,
      height: 65,
      child: ClipRRect(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 3,
                  ),
                  Container(
                    height: 64,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            widget.disableHomeButton ?
                            Container(
                              width: 50,
                              height: 3,
                              color: Colors.black,
                              margin: EdgeInsets.only(bottom: 5),
                            ) : Container(
                                margin: EdgeInsets.only(bottom: 5)
                            ),
                            Opacity(
                              opacity: widget.disableHomeButton ? 1 : 0.3,
                              child: IconButton(
                                icon: Image.asset(
                                  "assets/icon/home-icon.png",
                                  height: 25,
                                ),
                                tooltip: 'Home',
                                onPressed: () {
                                  if(!widget.disableHomeButton)
                                    _goToHomePage();
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            widget.disableCalendarButton ?
                            Container(
                              width: 50,
                              height: 3,
                              color: Colors.black,
                              margin: EdgeInsets.only(bottom: 5),
                            ) : Container(
                                margin: EdgeInsets.only(bottom: 5)
                            ),
                            Opacity(
                              opacity: widget.disableCalendarButton ? 1 : 0.3,
                              child: IconButton(
                                icon: Image.asset(
                                  "assets/icon/calendar-icon.png",
                                  height: 40,
                                ),
                                tooltip: 'Calendário',
                                onPressed: () {
                                  if(!widget.disableCalendarButton)
                                    _goToCalendar();
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            widget.disableNotesButton ?
                            Container(
                              width: 50,
                              height: 3,
                              color: Colors.black,
                              margin: EdgeInsets.only(bottom: 5),
                            ) : Container(
                                margin: EdgeInsets.only(bottom: 5)
                            ),
                            Opacity(
                              opacity: widget.disableNotesButton ? 1 : 0.2,
                              child: IconButton(
                                icon: Image.asset(
                                  "assets/icon/notes-icon.png",
                                  height: 40,
                                ),
                                tooltip: 'Anotações',
                                onPressed: () {
                                  if(!widget.disableNotesButton)
                                    _goToNotes();
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            widget.disableToDoButton ?
                            Container(
                              width: 50,
                              height: 3,
                              color: Colors.black,
                              margin: EdgeInsets.only(bottom: 5),
                            ) : Container(
                                margin: EdgeInsets.only(bottom: 5)
                            ),
                            Opacity(
                              opacity: widget.disableToDoButton ? 1 : 0.3,
                              child: IconButton(
                                icon: Image.asset(
                                  "assets/icon/todolist-icon.png",
                                  height: 25,
                                ),
                                tooltip: 'Lista de tarefas',
                                onPressed: () => _goToToDoPage(),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            widget.disableDisciplineButton ?
                            Container(
                              width: 50,
                              height: 3,
                              color: Colors.black,
                              margin: EdgeInsets.only(bottom: 5),
                            ) : Container(
                                margin: EdgeInsets.only(bottom: 5)
                            ),
                            Opacity(
                              opacity: widget.disableDisciplineButton ? 1 : 0.3,
                              child: IconButton(
                                icon: Image.asset(
                                  "assets/icon/discipline-icon.png",
                                  height: 25,
                                ),
                                tooltip: 'Matérias',
                                onPressed: () => _goToDisciplinePage(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
          )
      ),
    );

  }

  _goToHomePage(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  _goToCalendar(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CalendarPage()),
    );
  }

  _goToNotes(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotePage()),
    );
  }

  _goToToDoPage(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ToDoListPage()),
    );
  }

  _goToDisciplinePage(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DisciplinePage()),
    );
  }
}

