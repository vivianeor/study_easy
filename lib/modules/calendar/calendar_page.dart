import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:study_easy/core/components/action_button.dart';
import 'package:study_easy/core/components/bottom_navigator.dart';
import 'package:study_easy/core/utils/const_colors.dart';
import 'package:study_easy/modules/calendar/widgets/show_dialog_calendar.dart';
import 'package:table_calendar/table_calendar.dart';

import 'controller/calendar_controller.dart';
import 'model/calendar.dart';

class CalendarPage extends StatefulWidget {

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime selectedDate = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  TextEditingController nameEventController = TextEditingController();
  TextEditingController nameDisciplineController = TextEditingController();
  final CalendarController _controller = Get.put(CalendarController());
  final f = DateFormat('dd/MM/yyyy');
  final formKey = GlobalKey<FormState>();
  final formKeyDiscipline = GlobalKey<FormState>();
  var today = DateTime.now();

  @override
  void dispose() {
    nameEventController.dispose();
    nameDisciplineController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Calendário",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 27,
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width -40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.white,
                    ),
                    child: TableCalendar<Calendar>(
                      firstDay: DateTime(today.year, today.month - 3, today.day),
                      lastDay: DateTime(today.year, today.month + 12, today.day),
                      focusedDay: focusedDay,
                      calendarFormat: calendarFormat,
                      daysOfWeekVisible: true,
                      onFormatChanged: (format) {
                        setState(() {
                          calendarFormat = format;
                        });
                      },
                      onDaySelected: (DateTime selectDay, DateTime focusDay){
                        setState(() {
                          selectedDay = selectDay;
                          focusedDay = focusDay;
                        });
                      },
                      selectedDayPredicate: (DateTime date){
                        return isSameDay(selectedDay, date);
                      },
                      calendarStyle: CalendarStyle(
                        isTodayHighlighted: true,
                        selectedDecoration: BoxDecoration(
                          color: ConstColors.blue,
                          shape: BoxShape.circle
                        ),
                        todayDecoration: BoxDecoration(
                          color: ConstColors.yellow,
                          shape: BoxShape.circle,
                        )
                      ),
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "seus eventos",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold)
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 0.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        gradient: LinearGradient(
                          colors: [ConstColors.blue, ConstColors.yellow, ConstColors.background]
                        )
                    ),
                  ),
                  SizedBox(height: 8),
                  Obx(()=>
                      Visibility(
                        visible: _controller.calendar.isNotEmpty,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                  'Arraste para o lado para excluir ',
                                  style: TextStyle(
                                    fontFamily: "IndieFlower Regular",
                                    fontSize: 13,
                                    color: Color(0xffB1AEAE),
                                  )
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              width: 20,
                              height: 20,
                              child: Image.asset('assets/icon/curved-arrow.png', color: Color(0xffB1AEAE)))
                          ],
                        ),
                      ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: MediaQuery.of(context).size.width - 40,
                    child:
                    Obx(() =>
                      _controller.calendar.isEmpty?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Text('nenhum evento!',),
                          Container(
                            height: MediaQuery.of(context).size.height * .1,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      "assets/image/calendar.png",
                                    ),
                                    fit: BoxFit.contain
                                )
                            ),
                          ),
                          SizedBox(height: 20)
                        ],
                      )
                      :
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _controller.calendar.length, ///length
                        shrinkWrap: true,
                        itemBuilder: (context, index){
                          final calendar = _controller.calendar[index];
                          return Slidable(
                            key: Key(calendar.name),
                            actionPane: SlidableDrawerActionPane(),
                            secondaryActions: [
                              GestureDetector(
                                onTap: () => _showDialogDeleteEvent(context, calendar),
                                child: Container(
                                  width: 50,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.red,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.delete, color: Colors.white,),
                                      Text(
                                        'Excluir',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            child: Container(
                              height: 80,
                              margin: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * .87,
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width * .87,
                                          child: AutoSizeText(
                                            toBeginningOfSentenceCase(calendar.name)!,
                                            maxLines: 1,
                                          //  minFontSize: 15,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: calendar.nameDiscipline.toString().isNotEmpty,
                                          child: Container(
                                            width: MediaQuery.of(context).size.width * .87,
                                            child: AutoSizeText(
                                              toBeginningOfSentenceCase(calendar.nameDiscipline)!,
                                              maxLines: 1,
                                              //minFontSize: 15,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                 // fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ),
                                        AutoSizeText(
                                          f.format(calendar.date).toString(),
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 15,),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 60),)
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: ConstColors.blue,
              onPressed:() => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    title: Text('Adicione um evento', textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                    contentPadding: EdgeInsets.zero,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Form(
                            key: formKey,
                            child: TextFormField(
                              controller: nameEventController,
                              maxLength: 30,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'esse campo não pode ser vazio';
                                } return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Evento',
                                hintText: 'Insira o nome do evento',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Form(
                            key: formKeyDiscipline,
                            child: TextFormField(
                              controller: nameDisciplineController,
                              maxLength: 30,
                              decoration: InputDecoration(
                                labelText: 'Disciplina',
                                hintText: 'Insira o nome da disciplina',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 20, top: 20),
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
                              onTap: (){
                                if(formKey.currentState!.validate()){
                                  _controller.addCalendar(
                                      Calendar(name: nameEventController.text, date: selectedDay,
                                          nameDiscipline: nameDisciplineController.text));
                                  Navigator.pop(context);
                                  nameEventController.clear();
                                  nameDisciplineController.clear();
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
            bottomNavigationBar: BottomNavigatorApp(disableCalendarButton: true)
        ),
      ),
    );
  }

  _showDialogDeleteEvent(BuildContext context, Calendar calendar) {
    showDialog(
      context: context,
      builder: (context) => ShowDialogCalendar(calendar: calendar,)
    );
  }

}
