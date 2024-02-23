import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:study_easy/core/components/action_button.dart';
import 'package:study_easy/modules/todolist/controller/todo_controller.dart';
import 'package:study_easy/modules/todolist/model/todo.dart';

class ShowDialogToDoList extends StatefulWidget {
  final Todo todo;
  ShowDialogToDoList({
    required this.todo,
  });

  @override
  _ShowDialogToDoListState createState() => _ShowDialogToDoListState();
}

class _ShowDialogToDoListState extends State<ShowDialogToDoList> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.padding),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: contentBox(context),
      ),
    );
  }
  contentBox(context){
    final todoController = Get.find<TodoController>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: Constants.padding,top: 18
                + Constants.padding, right: Constants.padding,bottom: Constants.padding
            ),
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Peraí!',
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                Text(
                  'Você já concluiu essa tarefa?',
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ActionButton(
                        onTap: () {
                          todoController.deleteTodo(widget.todo);
                          Navigator.of(context).pop();
                        },
                        buttonText: 'Sim',
                        width: 100,
                        height: 45,
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                      ActionButton(
                        onTap: () => Navigator.of(context).pop(),
                        buttonText: 'Não',
                        width: 100,
                        height: 45,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Constants{
  Constants._();
  static const double padding =20;
  static const double avatarRadius =45;
}
