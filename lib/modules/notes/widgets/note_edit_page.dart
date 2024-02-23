import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:study_easy/core/components/action_button.dart';
import 'package:study_easy/core/components/main_app_bar.dart';
import 'package:study_easy/core/utils/const_colors.dart';
import 'package:study_easy/modules/notes/controller/note_controller.dart';
import 'package:study_easy/modules/notes/model/note.dart';
import 'package:study_easy/modules/notes/widgets/show_dialog_note.dart';

class NoteEditPage extends StatefulWidget {
  final Note notes;
  NoteEditPage({
    required this.notes,
  });

  @override
  _NoteEditPageState createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  var titleController = TextEditingController();
  var textController = TextEditingController();
  late String title;
  late String text;

  @override
  void initState() {
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    final notes = widget.notes;
    titleController.text = notes.title;
    textController.text = notes.text;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    textController.dispose();
    super.dispose();
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
                width: MediaQuery.of(context).size.width - 40,
                child: Text(
                  "editar nota",
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
                          controller: titleController,
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
                            title = value;
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
                          controller: textController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          onChanged: (value){
                            text = value;
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
                      onTap: () => _showDialogDeleteEvent(context),
                      width: (MediaQuery.of(context).size.width - 20 ) / 2.7,
                      height: 50,
                      buttonText: 'Excluir',
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                    ActionButton(
                      onTap: () {
                        noteController.updateNote(widget.notes, titleController.text, textController.text);
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

  _showDialogDeleteEvent(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ShowDialogNote(
        note: widget.notes,
      )
    );
  }
}

class Constants{
  Constants._();
  static const double padding =20;
  static const double avatarRadius =45;
}
