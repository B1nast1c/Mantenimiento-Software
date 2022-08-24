import 'package:flutter/material.dart';
import '../constants/colors.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({Key? key}) : super(key: key);

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  String? _text = ''; //Texto dentro de la nota
  final _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tdBGColor,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text('Nueva Nota'),
      ),
    );
  }
}
