import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:study_easy/core/components/action_button.dart';
import 'package:study_easy/core/components/main_app_bar.dart';
import 'package:study_easy/core/utils/const_colors.dart';
import 'package:study_easy/modules/notes/controller/note_controller.dart';
import 'package:study_easy/modules/notes/model/note.dart';

class NoteCreatePage extends StatefulWidget {

  @override
  _NoteCreatePageState createState() => _NoteCreatePageState();
}

class _NoteCreatePageState extends State<NoteCreatePage> {
  GlobalKey<ScaffoldState>? _scaffoldKey;
  var note = Note(title: '', text: '', titleFolder: '');

  @override
  void initState() {
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final noteController = Get.find<NoteController>();
    return SafeArea(
      top: true,
      left: false,
      right: false,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: ConstColors.background,
        appBar: MainAppBar(backgroundColor: Colors.white, showBackButton: true, transparentBackground: true,),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  "criar nota",
                  style: TextStyle(
                      color: ConstColors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width - 40,
                  height: MediaQuery.of(context).size.height - 240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 70,
                        padding: EdgeInsets.only(top: 15),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Título',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 23,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.bold
                          ),
                          onChanged: (value){
                            note.title = value;
                          },
                        ),
                      ),
                      Container(
                        color: ConstColors.lightBlue,
                        height: 1,
                        width: MediaQuery.of(context).size.width - 70,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 70,
                        height: MediaQuery.of(context).size.height - 350,
                        padding: EdgeInsets.only(top: 15),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          onChanged: (value){
                            note.text = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ActionButton(
                      onTap: () => Navigator.of(context).pop(),
                      width: (MediaQuery.of(context).size.width - 20 ) / 2.7,
                      height: 50,
                      buttonText: 'Cancelar',
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                    ActionButton(
                      onTap: () async {
                        noteController.addNote(note);
                        Navigator.of(context).pop();
                      },
                      width: (MediaQuery.of(context).size.width - 20 ) / 2.7,
                      height: 50,
                      buttonText: 'Salvar',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
