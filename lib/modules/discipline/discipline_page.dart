import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:study_easy/core/components/action_button.dart';
import 'package:study_easy/core/components/bottom_navigator.dart';
import 'package:study_easy/core/utils/const_colors.dart';
import 'package:study_easy/modules/discipline/widgets/discipline_edit.dart';
import 'package:study_easy/modules/discipline/widgets/show_dialog_discipline.dart';

import 'controller/discipline_controller.dart';
import 'model/discipline.dart';


class DisciplinePage extends StatefulWidget {
  const DisciplinePage({Key? key}) : super(key: key);

  @override
  _DisciplinePageState createState() => _DisciplinePageState();
}

class _DisciplinePageState extends State<DisciplinePage> {
  TextEditingController nameDisciplineController = TextEditingController();
  TextEditingController n1Controller = TextEditingController();
  TextEditingController n2Controller = TextEditingController();
  TextEditingController n3Controller = TextEditingController();
  final formKeyN1 = GlobalKey<FormState>();
  final formKeyN2 = GlobalKey<FormState>();
  final formKeyN3 = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final _controller = Get.find<DisciplineController>();
  String? errorMessage;

  @override
  void initState() {
    n1Controller.text = '';
    n2Controller.text = '';
    n3Controller.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: GetBuilder(
          init: DisciplineController(),
          builder: (DisciplineController disciplineController) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Stack(
                  children: [
                    Obx(() =>
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 30,
                          height: MediaQuery.of(context).size.height,
                          child:
                          (_controller.discipline.isEmpty)
                              ?
                          Padding(
                            padding: EdgeInsets.only(top: 250),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 20),
                                Text('nenhuma matéria!',),
                                Container(
                                  height: MediaQuery.of(context).size.height * .15,
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
                            ),
                          )
                              :
                          ListView.builder(
                              padding: EdgeInsets.only(top: 90, bottom: 130),
                              itemCount: _controller.discipline.length,
                              //physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index){
                                var discipline = disciplineController.discipline[index];
                                return Slidable(
                                  key: Key(discipline.name),
                                  actionPane: SlidableDrawerActionPane(),
                                  secondaryActions: [
                                    GestureDetector(
                                      onTap: () => _showDialogDeleteDiscipline(discipline),
                                      child: Container(
                                        width: 50,
                                        height: 130,
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
                                    GestureDetector(
                                      onTap: () => _showDialogEditDiscipline(discipline),
                                      child: Container(
                                        width: 50,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(14),
                                          color: Colors.green,
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.edit, color: Colors.white),
                                            Text(
                                              'Editar',
                                              style: TextStyle(color: Colors.white)
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                  child: Container(
                                    height: 130,
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.white
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 15),
                                          width: MediaQuery.of(context).size.width * .64,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              AutoSizeText(
                                                discipline.name,
                                                maxLines: 3,
                                                minFontSize: 20,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * .26,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              discipline.nota1 != null ?
                                              Text(
                                                'Nota 1: ${discipline.nota1}',
                                                style: TextStyle(fontSize: 16),
                                              ) :
                                              Text('Nota 1:', style: TextStyle(fontSize: 16)),
                                              discipline.nota2 != null ?
                                              Text(
                                                'Nota 2: ${discipline.nota2.toString()}',
                                                style: TextStyle(fontSize: 16),
                                              ) :
                                              Text('Nota 2:', style: TextStyle(fontSize: 16)),
                                              discipline.nota3 != null ?
                                              Text(
                                                'Nota 3: ${discipline.nota3.toString()}',
                                                style: TextStyle(fontSize: 16),
                                              ) :
                                              Text('Nota 3:', style: TextStyle(fontSize: 16)),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                          ),
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
                        "Matérias e Notas",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 27,
                          fontWeight: FontWeight.bold)),
                    ),
                    Obx(()=>
                      Visibility(
                        visible: _controller.discipline.isNotEmpty,
                        child: Positioned(
                          top: 72,
                          right: 20,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  'Arraste para o lado para editar ou excluir ',
                                  style: TextStyle(
                                    fontFamily: "IndieFlower Regular",
                                    fontSize: 15,
                                    color: Color(0xffB1AEAE),
                                  )
                                ),
                              ),
                              Container(
                                width: 20,
                                height: 20,
                                child: Image.asset('assets/icon/curved-arrow.png', color: Color(0xffB1AEAE)))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
           }
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ConstColors.blue,
          onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                title: Text('Adicione suas notas',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                scrollable: true,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: nameDisciplineController,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'esse campo não pode ser vazio';
                            } return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Nome da disciplina',
                            hintText: 'Insira o nome da disciplina',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: n1Controller,
                        maxLength: 4,
                        onChanged: (value){
                          var valor = double.tryParse(n1Controller.text)! + 0.00;
                          valor.toStringAsFixed(2);
                        },
                        inputFormatters: regEx,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Nota 1',
                          hintText: 'Insira a nota 1, ex: 8.5',
                          counterText:''
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: n2Controller,
                        maxLength: 2,
                        onChanged: (value){
                          var valor = double.tryParse(n2Controller.text)! + 0.00;
                          valor.toStringAsFixed(2);
                        },
                        inputFormatters: regEx,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Nota 2',
                          hintText: 'Insira a nota 2, ex: 8.5',
                          counterText: ''
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: n3Controller,
                        maxLines: 2,
                        onChanged: (value){
                          var valor = double.tryParse(n3Controller.text)! + 0.00;
                          valor.toStringAsFixed(2);
                        },
                        inputFormatters: regEx,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Nota 3',
                          hintText: 'Insira a nota 3, ex: 8.5',
                          counterText: ''
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Text(
                        'Obs.: Os campos de notas são opicionais e não aceitam letras ou caracteres especiais, '
                            'apenas números. Ex: 8 ou 8.5',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff7d7878),
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ActionButton(
                          width: 100,
                          height: 45,
                          buttonText:'Cancel',
                          onTap: () {
                            Navigator.pop(context);
                            nameDisciplineController.clear();
                            n1Controller.clear();
                            n2Controller.clear();
                            n3Controller.clear();
                          }
                        ),
                        SizedBox(width: 15),
                        ActionButton(
                          width: 100,
                          height: 45,
                          buttonText: 'Salvar',
                          onTap: (){
                          if(formKey.currentState!.validate()){
                            _controller.addDiscipline(
                                Discipline(name: nameDisciplineController.text,
                                nota1: double.tryParse(n1Controller.text), nota2: double.tryParse(n2Controller.text),
                                nota3: double.tryParse(n3Controller.text)
                                ));
                            Navigator.pop(context);
                            nameDisciplineController.clear();
                            n1Controller.clear();
                            n2Controller.clear();
                            n3Controller.clear();
                          }
                        }),
                      ],
                    ),
                  ),
                ],
              )),
          child: Icon(
            Icons.add,
            color: Colors.white,),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          bottomNavigationBar: BottomNavigatorApp(disableDisciplineButton: true)
      ),
    );
  }

  _showDialogEditDiscipline(Discipline discipline) {
    showDialog(
        context: context,
        builder: (context) => DisciplineEdit(discipline: discipline)
    );
  }

  _showDialogDeleteDiscipline(Discipline discipline) {
    showDialog(
        context: context,
        builder: (context) => ShowDialogDiscipline(discipline: discipline)
    );
  }

  List<TextInputFormatter>? regEx = [
    FilteringTextInputFormatter.deny(RegExp("[,]")),
    FilteringTextInputFormatter.deny(RegExp("[a-zA-Z]")),
    FilteringTextInputFormatter.deny(RegExp("[@]")),
    FilteringTextInputFormatter.deny(RegExp("[\$]")),
    FilteringTextInputFormatter.deny(RegExp("[\%]")),
    FilteringTextInputFormatter.deny(RegExp("[\#]")),
    FilteringTextInputFormatter.deny(RegExp("[\[]")),
    FilteringTextInputFormatter.deny(RegExp("[\]]")),
    FilteringTextInputFormatter.deny(RegExp("[\(]")),
    FilteringTextInputFormatter.deny(RegExp("[\)]")),
    FilteringTextInputFormatter.deny(RegExp("[\"]")),
    FilteringTextInputFormatter.deny(RegExp("[\']")),
    FilteringTextInputFormatter.deny(RegExp("[\/]")),
    FilteringTextInputFormatter.deny(RegExp("[\{]")),
    FilteringTextInputFormatter.deny(RegExp("[\}]")),
    FilteringTextInputFormatter.deny(RegExp("[&]")),
    FilteringTextInputFormatter.deny(RegExp("[_]")),
    FilteringTextInputFormatter.deny(RegExp("[+]")),
    FilteringTextInputFormatter.deny(RegExp("[-]")),
    FilteringTextInputFormatter.deny(RegExp("[ ]")),
    FilteringTextInputFormatter.deny(RegExp("[*]")),
    FilteringTextInputFormatter.deny(RegExp("[:]")),
    FilteringTextInputFormatter.deny(RegExp("[;]")),
    FilteringTextInputFormatter.deny(RegExp("[!]")),
    FilteringTextInputFormatter.deny(RegExp("[?]")),
    FilteringTextInputFormatter.deny(RegExp("[~]")),
    FilteringTextInputFormatter.deny(RegExp("[´]")),
    FilteringTextInputFormatter.deny(RegExp("[`]")),
    FilteringTextInputFormatter.deny(RegExp("[|]")),
  ];

}
