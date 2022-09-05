import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/todo.dart';

import '../constants/colors.dart';
import '../widgets/color_picker.dart';

class EditTodo extends StatefulWidget {
  const EditTodo({Key? key, required this.item}) : super(key: key);
  final ToDo item;

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  Color _color = Colors.white;
  late TextEditingController _todoControllerTitle, _todoControllerContent;

  @override
  void initState() {
    super.initState();
    _todoControllerTitle =
        new TextEditingController(text: widget.item.todoTitle);
    _todoControllerContent =
        new TextEditingController(text: widget.item.todoText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: rojoIntenso,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(250),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 40.0,
                            horizontal: 10.0), //apply padding to all four sides
                        child: Text(
                          'Editar Nota',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30, bottom: 10),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Título',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w300),
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
                            hintText: 'Título',
                            hintStyle: const TextStyle(
                              color: tdGrey,
                            ),
                            fillColor: tdBGColor),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30, bottom: 10, top: 20),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Descripción',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w300),
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
                        initialValue: widget.item.todoText,
                        onChanged: (value) => _todoControllerContent.text =
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
                            hintText: 'Descripción',
                            hintStyle: const TextStyle(
                              color: tdGrey,
                            ),
                            fillColor: tdBGColor),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 20.0, left: 30.0),
                      child: const Text(
                        'Escoge un color para la nota',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
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
                      _editToDoItem(_todoControllerTitle.text,
                          _todoControllerContent.text);
                      Navigator.pop(context);
                    },
                  ),
                )),
              ],
            )));
  }

  void _editToDoItem(String toDoTitle, String toDoContent) {
    setState(() {
      widget.item.todoTitle = toDoTitle; //Title asignment
      widget.item.todoText = toDoContent; //Text asignment
      widget.item.ncolor = _color;
    });
  } //Logica del cambio
}
