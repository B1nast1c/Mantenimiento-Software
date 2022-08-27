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
  final _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: AppBar(
          backgroundColor: tdBGColor,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Column(
          children: [
            Padding(
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
            Container(
              margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                onChanged: (value) => _todoController.text =
                    value, //Actualización del valor del input
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20.0),
                  border: InputBorder.none,
                  hintText: 'Ingresa tu nota...',
                  hintStyle: TextStyle(
                    color: tdGrey,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 20.0, left: 30.0),
              child: Text(
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
            Expanded(
              child: Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.only(right: 25.0, bottom: 25.0),
              child: IconButton(
                icon: Icon(Icons.check),
                color: Colors.green,
                iconSize: 35.0,
                onPressed: () {
                  _addToDoItem(_todoController.text);
                  Navigator.pop(context);
                },
              ),
            )),
          ],
        ));
  }

  void _addToDoItem(String toDo) {
    //Añadir un nuevo elemento
    setState(() {
      widget.list.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
        ncolor: _color
      ));
    });
    _todoController.clear();
  }
}
