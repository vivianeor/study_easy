import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:study_easy/core/components/bottom_navigator.dart';
import 'package:study_easy/core/utils/const_colors.dart';
import 'package:study_easy/modules/calendar/controller/calendar_controller.dart';
import 'package:study_easy/modules/todolist/controller/todo_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  final todoController = Get.find<TodoController>();
  final f = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
       //appBar: MainAppBar(transparentBackground: true, backgroundColor: Colors.white),
        body: SingleChildScrollView(
          child: Column(
          //  mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 30),
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/image/home.png",
                        ),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  Positioned(
                    left: 30,
                    top: 25,
                    child: Container(
                      child: Text(
                        'Olá!',
                        style: TextStyle(
                          color: Color(0xffB1AEAE),
                          fontSize: 25
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: ConstColors.background,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  )
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      child: Text(
                        "seus próximos eventos",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 3),
                      width: MediaQuery.of(context).size.width - 60,
                      height: 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          gradient: LinearGradient(
                            colors: [ConstColors.blue, ConstColors.yellow, ConstColors.background]
                          )
                      ),
                    ),
                    GetBuilder(builder: (CalendarController calendarController) {
                      return Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        height: calendarController.calendar.length > 0 ?
                        MediaQuery.of(context).size.height * .25:
                        MediaQuery.of(context).size.height * .1,
                        width: MediaQuery.of(context).size.width - 40,
                        child: calendarController.calendar.isEmpty ?
                        Center(child: Text('nenhum evento!')) :
                        Center(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: calendarController.calendar.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 130,
                                margin: EdgeInsets.symmetric(horizontal: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 3),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(color: ConstColors.yellow,
                                            borderRadius: BorderRadius.circular(70),
                                          ),
                                          child: Align(
                                            child: Image.asset(
                                              "assets/icon/calendar-icon.png",
                                              height: 25
                                            ),
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.only(bottom: 10)),
                                        Container(
                                          height: 50,
                                          child: AutoSizeText(
                                            toBeginningOfSentenceCase(calendarController.calendar[index].name)!,
                                            maxLines: 2,
                                            minFontSize: 16,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            )
                                          ),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          f.format(calendarController.calendar[index].date).toString(),
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black
                                          )
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              );
                            }
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: ConstColors.background,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                    )
                ),
                child: Column(
                  children: [
                  SizedBox(height: 8),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Text(
                      "suas tarefas a concluir",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 8, top: 3),
                    width: MediaQuery.of(context).size.width - 60,
                    height: 0.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        gradient: LinearGradient(
                            colors: [ConstColors.blue, ConstColors.yellow, ConstColors.background]
                        )
                    ),
                  ),
                  GetBuilder(builder: (TodoController todoController) {
                    return Container(
                      height: MediaQuery.of(context).size.height * .32,
                      width: MediaQuery.of(context).size.width - 40,
                      child: todoController.listTask.isEmpty ?
                      Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(top: 20),
                          child: Text('nenhuma tarefa!'))
                      :
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.zero,
                          itemCount: todoController.listTask.length,
                          itemBuilder:(context, index){
                            return Container(
                              margin: EdgeInsets.only(bottom: 5, top: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(padding: EdgeInsets.only(left: 10)),
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: ConstColors.blue,
                                        borderRadius: BorderRadius.circular(70),
                                      ),
                                      child: Align(
                                        child: Image.asset(
                                            "assets/icon/todolist-icon.png",
                                            height: 18
                                        ),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                                    Container(
                                      width: MediaQuery.of(context).size.width * .68,
                                      child: AutoSizeText(
                                          toBeginningOfSentenceCase(todoController.listTask[index].title).toString(),
                                          maxLines: 1,
                                          minFontSize: 16,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 16)
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigatorApp(disableHomeButton: true)
      ));
  }
}
