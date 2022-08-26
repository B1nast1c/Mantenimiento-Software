import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ToDo {
  String? id;
  String? todoText;
  bool isDone;
  //String? color; //Color de la nota Este no funciona
  Color? ncolor; // Este si

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
    this.ncolor = Colors.white
  });


  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Morning Excercise', isDone: true , ncolor: verdeClaro ),
      ToDo(id: '02', todoText: 'Buy Groceries', isDone: true, ncolor: azulClaro ),
      ToDo(id: '03', todoText: 'Check Emails', ncolor: rojoClaro),
      ToDo(id: '04', todoText: 'Team Meeting', ncolor: amarilloClaro),
      ToDo(id: '05', todoText: 'Work on mobile apps for 2 hour', ),
      ToDo(id: '06', todoText: 'Dinner with Jenny', ),
    ];
  }
}