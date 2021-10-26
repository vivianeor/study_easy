import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:study_easy/core/components/bottom_navigator.dart';
import 'package:study_easy/core/utils/const_colors.dart';
import 'package:study_easy/modules/notes/widgets/note_create_page.dart';
import 'package:study_easy/modules/notes/widgets/note_edit_page.dart';

import 'controller/note_controller.dart';
import 'model/note.dart';

class NotePage extends StatefulWidget {
  const NotePage();

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: GetBuilder(
          init: NoteController(),
          builder: (NoteController noteController) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Stack(
                    children: [
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 30,
                          height: MediaQuery.of(context).size.height,
                          child: (noteController.notes.isEmpty)
                              ?
                          Padding(
                            padding: EdgeInsets.only(top: 250),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 20),
                                Text('nenhuma anotação!',),
                                Container(
                                  height: MediaQuery.of(context).size.height * .15,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                            "assets/image/notes.png",
                                          ),
                                          fit: BoxFit.contain
                                      )
                                  ),
                                ),
                                SizedBox(height: 20)
                              ],
                            ),
                          )
                              :
                          ListView.builder(
                              padding: EdgeInsets.only(top: 80, bottom: 130),
                              itemCount: noteController.notes.length,
                              //physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index){
                                var note = noteController.notes[index];
                                return Container(
                                  height: 70,
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(right: 5, left: 15, top: 15),
                                        width: MediaQuery.of(context).size.width - 90,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              note.title,
                                              maxLines: 1,
                                              minFontSize: 15,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            AutoSizeText(
                                              note.text,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => _goToNoteEditPage(note),
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          width: 40,
                                          height: 40,
                                          child: Image.asset(
                                            "assets/icon/edit-icon.png",
                                            color: ConstColors.yellow, fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .12,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.25, 1],
                                colors: [
                                  Colors.white,
                                  Colors.white.withOpacity(0),
                                ]
                            )
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Anotações",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 27,
                            fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ConstColors.blue,
          onPressed: () => _goToNoteCreatePage(),
          child: Icon(
            Icons.add,
            color: Colors.white,),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomNavigatorApp(disableNotesButton: true)
      ),
    );
  }


  _goToNoteEditPage(Note note){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteEditPage(notes: note)
      ),
    );
  }

  _goToNoteCreatePage(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteCreatePage()),
    );
  }
}
