import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:study_easy/core/components/action_button.dart';
import 'package:study_easy/core/components/bottom_navigator.dart';
import 'package:study_easy/core/utils/const_colors.dart';
import 'package:study_easy/modules/todolist/widgets/show_dialog_todo.dart';

import 'controller/todo_controller.dart';
import 'model/todo.dart';

class ToDoListPage extends StatefulWidget {

  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> with WidgetsBindingObserver {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameTaskController = TextEditingController();
  final TodoController todoController = Get.put(TodoController());
  String dropdownValue = 'Baixa';
  List<String> dropdownList = ['Baixa', 'Média', 'Alta'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      todoController.getItems();
    });
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Stack(
                    children: [
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 30,
                          height: MediaQuery.of(context).size.height,
                          child:
                          Obx(() =>
                           (todoController.listTask.isEmpty) ?
                            Padding(
                              padding: EdgeInsets.only(top: 250),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 20),
                                  Text('nenhuma tarefa!',),
                                  Container(
                                    height: MediaQuery.of(context).size.height * .15,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          "assets/image/todo.png",
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
                              itemCount: todoController.listTask.length,
                              //physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                              var _todo = todoController.listTask[index];
                              return Container(
                                height: 60,
                                margin: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.white,
                                ),
                                child: CheckboxListTile(
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 3),
                                      AutoSizeText(
                                        toBeginningOfSentenceCase(_todo.title)!,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          colorPriority(_todo.priority!),
                                          SizedBox(width: 5),
                                          AutoSizeText(
                                            '${_todo.priority} prioridade',
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  key: Key(_todo.id),
                                  activeColor: ConstColors.yellow,
                                  checkColor: ConstColors.yellow,
                                  value: _todo.isCompleted,
                                  onChanged: (value) {
                                    _showDialogCheckTask(_todo);
                                  }
                                ),
                              );
                            }),
                          )
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
                            "Tarefas",
                            style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 20),)
                    ],
                  ),
                ],
              ),
            ),
        bottomNavigationBar: BottomNavigatorApp(disableToDoButton: true),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ConstColors.blue,
          onPressed:() => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                title: Text('Adicione uma tarefa', textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: formKey,
                        child: TextFormField(
                          controller: nameTaskController,
                          maxLength: 30,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'esse campo não pode ser vazio';
                            } return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Insira a tarefa',
                          ),
                        ),
                      ),
                    StatefulBuilder(
                      builder: (BuildContext context, StateSetter dropDownState){
                        return DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.expand_more_outlined, color: ConstColors.blue),
                          iconSize: 24,
                          elevation: 16,
                          isExpanded: true,
                          underline: Container(height: 1, color: Colors.grey,),
                          onChanged: (value) {
                            dropDownState(() {
                              dropdownValue = value!;
                              print('dropdownValue $dropdownValue');
                            });
                          },
                          items: dropdownList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        );
                      }),
                    ],
                  ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ActionButton(
                            width: 100,
                            height: 45,
                            buttonText:'Cancel',
                            onTap: () => Navigator.pop(context)
                        ),
                        SizedBox(width: 15),
                        ActionButton(
                          width: 100,
                          height: 45,
                          buttonText: 'Salvar',
                          onTap: () async {
                            if(formKey.currentState!.validate()){
                              var _model = Todo(title: nameTaskController.text, priority: dropdownValue);
                            //  todoController.listTask.add(_model);
                              await todoController.addTodo(_model);
                              nameTaskController.clear();
                              Navigator.pop(context);
                            }
                          }),
                      ],
                    ),
                  ),
                ],
              )),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget colorPriority(String priority) {
    if (priority == 'Baixa') {
      return Container(
          height: 8, width: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.green,
          )
      );
    } else if (priority == 'Média') {
      return Container(
          height: 8, width: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.yellow,
          )
      );
    } else {
      return Container(
          height: 8, width: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.red,
          )
      );
    }
  }

  _showDialogCheckTask(Todo todo) {
    Future.delayed(Duration.zero, () async {
      showDialog(
        context: context,
        builder: (BuildContext context){
          return ShowDialogToDoList(todo: todo);
        }
      );
   });
  }

}