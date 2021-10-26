import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:study_easy/core/components/action_button.dart';
import 'package:study_easy/modules/discipline/controller/discipline_controller.dart';
import 'package:study_easy/modules/discipline/model/discipline.dart';

class DisciplineEdit extends StatefulWidget {
  final Discipline discipline;
  DisciplineEdit({
    required this.discipline,
  });

  @override
  _DisciplineEditState createState() => _DisciplineEditState();
}

class _DisciplineEditState extends State<DisciplineEdit> {
  var nameDisciplineController = TextEditingController();
  var n1Controller = TextEditingController();
  var n2Controller = TextEditingController();
  var n3Controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formKeyN1 = GlobalKey<FormState>();
  final formKeyN2 = GlobalKey<FormState>();
  final formKeyN3 = GlobalKey<FormState>();
  late String name;
  late double n1;
  late double n2;
  late double n3;

  @override
  void initState() {
    final discipline = widget.discipline;
    nameDisciplineController.text = discipline.name;
    n1Controller.text = discipline.nota1 != null ? discipline.nota1.toString() : '';
    n2Controller.text = discipline.nota2 != null ? discipline.nota2.toString() : '';
    n3Controller.text = discipline.nota3 != null ? discipline.nota3.toString(): '';
    super.initState();
  }

  @override
  void dispose() {
    nameDisciplineController.dispose();
    n1Controller.dispose();
    n2Controller.dispose();
    n3Controller.dispose();
    super.dispose();
  }

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
            child: contentBox(context)
        )
    );
  }
  Widget contentBox(context){
    final _controller = Get.find<DisciplineController>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: Constants.padding,
                  bottom: Constants.padding),
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
                    'Edite suas notas',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        controller: nameDisciplineController,
                        onChanged: (value) => name = value,
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
                    child: Form(
                      key: formKeyN1,
                      child: TextFormField(
                        controller: n1Controller,
                        onChanged: (value) => n1 = double.parse(value),
                        inputFormatters: regEx,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Nota 1',
                          hintText: 'Insira a nota 1, ex: 8.5',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: n2Controller,
                      inputFormatters: regEx,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => n2 = double.parse(value),
                      decoration: InputDecoration(
                        labelText: 'Nota 2',
                        hintText: 'Insira a nota 2, ex: 8.5',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: n3Controller,
                      inputFormatters: regEx,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => n3 = double.parse(value),
                      decoration: InputDecoration(
                        labelText: 'Nota 3',
                        hintText: 'Insira a nota 3, ex: 8.5',
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
                       // fontFamily: "IndieFlower Regular",
                        fontSize: 13,
                        color: Color(0xff7d7878),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ActionButton(
                          onTap: () {
                            Navigator.pop(context);
                            nameDisciplineController.clear();
                            n1Controller.clear();
                            n2Controller.clear();
                            n3Controller.clear();
                          },
                          buttonText: 'Cancelar',
                          width: 100,
                          height: 45,
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                        ActionButton(
                          width: 100,
                          height: 45,
                          buttonText: 'Salvar',
                          onTap: (){
                            if(formKey.currentState!.validate()){
                              _controller.updateDiscipline(widget.discipline,
                                  nameDisciplineController.text,
                                  double.tryParse(n1Controller.text),
                                  double.tryParse(n2Controller.text),
                                  double.tryParse(n3Controller.text)
                              );
                              Navigator.of(context).pop();
                            }
                          }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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

class Constants{
  Constants._();
  static const double padding =20;
  static const double avatarRadius =45;
}

