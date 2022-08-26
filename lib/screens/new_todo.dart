import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../constants/colors.dart';
import '../screens/home.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({Key? key, required this.list}) : super(key: key);
  final List<ToDo> list;

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
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
                onChanged: (value) => _todoController.text = value, //Actualización del valor del input
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
                  },
              ),
            )),
          ],
        ));
  }

  void _addToDoItem(String toDo) { //Añadir un nuevo elemento
    setState(() {
      widget.list.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    _todoController.clear();
  }
}

