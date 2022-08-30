import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ToDo {
  String? id;
  String? todoTitle;
  String? todoText;
  bool isDone;
  Color? ncolor;

  ToDo(
      {required this.id,
      required this.todoTitle,
      required this.todoText,
      this.isDone = false,
      this.ncolor = Colors.white});

  static List<ToDo> todoList() {
    return [
      ToDo(
          id: '03',
          todoTitle: 'Hola',
          todoText: 'Check Emails',
          ncolor: rojoClaro),
    ];
  }
}
