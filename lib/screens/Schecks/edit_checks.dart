import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/check.dart';
import '/../constants/colors.dart';
import '/../widgets/color_picker.dart';
import 'package:provider/provider.dart';
import '/../providers/provider.dart';
import 'package:intl/intl.dart';

String editdate = DateFormat.yMMMEd().format(DateTime.now());

class EditCheck extends StatefulWidget {
  const EditCheck({Key? key, required this.item}) : super(key: key);

  final Check item;

  @override
  State<EditCheck> createState() => _EditCheckState();
}

class _EditCheckState extends State<EditCheck> {
  Color _color = Colors.white;
  late TextEditingController _todoControllerTitle;

  @override
  void initState() {
    super.initState();
    _todoControllerTitle = TextEditingController(text: widget.item.todoTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: weso,
        appBar: AppBar(
          backgroundColor: context.read<Changes>().darkModes? Colors.white: NegroSuave,
          foregroundColor: context.read<Changes>().darkModes?  Colors.black: Colors.white,
          elevation: 0,
        ),
        body: Container(
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(250),
              ),
              color: context.read<Changes>().darkModes?  Colors.white: NegroSuave,
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 15.0),
                      child: _seeLanguage()
                          ? Text(
                              'Edit Check',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w500,
                                color: context.read<Changes>().darkModes? Colors.black:Colors.white
                              ),
                            )
                          : Text(
                              'Editar Check',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w500,
                                color: context.read<Changes>().darkModes? Colors.black:Colors.white
                              ),
                            ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            _seeLanguage()
                                ? Text(
                                    'Created at: ${widget.item.date}',
                                    style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: rojoIntenso),
                                    textAlign: TextAlign.left,
                                  )
                                : Text(
                                    'Creado el: ${widget.item.date}',
                                    style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: rojoIntenso),
                                    textAlign: TextAlign.left,
                                  ),
                            Container(
                                child: widget.item.editdate == null
                                    ? Container()
                                    : _seeLanguage()
                                        ? Text(
                                            'Last edition at: ${widget.item.editdate}',
                                            style: const TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: rojoIntenso),
                                          )
                                        : Text(
                                            'Última edición el: ${widget.item.editdate}',
                                            style: const TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: rojoIntenso),
                                          )),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 30, bottom: 10),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: _seeLanguage()
                            ? Text(
                                'Title',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300,
                                    color: context.read<Changes>().darkModes? Colors.black:Colors.white),
                              )
                            : Text(
                                'Título',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300,
                                    color: context.read<Changes>().darkModes? Colors.black:Colors.white),
                              ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        initialValue: widget.item.todoTitle,
                        onChanged: (value) => _todoControllerTitle.text =
                            value, //Actualización del valor del input
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 25.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100.0),
                              borderSide: const BorderSide(
                                  color: tdBGColor, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: rojoIntenso, width: 1.0),
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            hintText: _seeLanguage()
                                ? 'Enter a new title'
                                : 'Ingresa un nuevo título',
                            hintStyle: const TextStyle(
                              color: tdGrey,
                            ),
                            fillColor: tdBGColor),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 20.0, left: 30.0),
                      child: _seeLanguage()
                          ? Text(
                              'Choose a new color',
                              style: TextStyle(
                                fontSize: 16.5,
                                fontWeight: FontWeight.w400,
                                color: context.read<Changes>().darkModes? Colors.black:Colors.white
                              ),
                            )
                          : Text(
                              'Escoge un nuevo color',
                              style: TextStyle(
                                fontSize: 16.5,
                                fontWeight: FontWeight.w400,
                                color: context.read<Changes>().darkModes? Colors.black:Colors.white
                              ),
                            ),
                    ),
                    ColorPicker(
                        onSelectedColor: (value) {
                          setState(() {
                            _color = value;
                          });
                        },
                        chosenColor: _color),
                  ],
                ),
                Expanded(
                    child: Container(
                  alignment: Alignment.bottomRight,
                  margin: const EdgeInsets.only(right: 25.0, bottom: 25.0),
                  child: IconButton(
                    icon: const Icon(Icons.check),
                    color: Colors.green,
                    iconSize: 35.0,
                    onPressed: () {
                      _editToDoItem(_todoControllerTitle.text);
                      Navigator.pop(context);
                    },
                  ),
                )),
              ],
            )));
  }

  void _editToDoItem(String toDoTitle) {
    setState(() {
      //Asignación de la categoría al editarlo
      widget.item.todoTitle = toDoTitle;
      widget.item.ncolor = _color;
      widget.item.editdate = editdate;
      widget.item.datef = DateTime.now();
      context.read<Changes>().changeUsedTrue();
    });
  }

  bool _seeLanguage() {
    if (context.read<Changes>().language == "ESP") {
      return false;
    }
    return true;
  }
}
