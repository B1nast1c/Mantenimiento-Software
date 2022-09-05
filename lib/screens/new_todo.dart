import 'dart:ui';

import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/color_picker.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({Key? key, required this.list}) : super(key: key);
  final List<ToDo> list;

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  Color _color = Colors.white;
  final _todoControllerTitle = TextEditingController();
  final _todoControllerContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: rojoIntenso,
        appBar: AppBar(
          backgroundColor: rojoIntenso,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(60),
                topRight: Radius.circular(60),
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
                          'Nueva Nota',
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
                        chosenColor: Colors.white),
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
                      _addToDoItem(_todoControllerTitle.text,
                          _todoControllerContent.text);
                      Navigator.pop(context);
                    },
                  ),
                )),
              ],
            )));
  }

  void _addToDoItem(String toDoTitle, String toDoContent) {
    setState(() {
      widget.list.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoTitle: toDoTitle,
          todoText: toDoContent,
          ncolor: _color));
    });
    _todoControllerTitle.clear();
    _todoControllerContent.clear();
  }
}
