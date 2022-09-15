import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ToDo {
  String? id;
  String? todoTitle;
  String? todoText;
  bool isDone;
  Color? ncolor;
  String? category;

  ToDo(
      {required this.id,
      required this.todoTitle,
      required this.todoText,
      this.isDone = false,
      this.ncolor = Colors.white,
      this.category = 'Uncategorized'});

  static List<ToDo> todoList() {
    return [
      ToDo(
          id: '02',
          todoTitle: 'Texto sin categoría',
          todoText: 'Check Emails',
          ncolor: rojoClaro,
          category: 'Uncategorized'),
      ToDo(
          id: '03',
          todoTitle: 'Texto Personal',
          todoText: 'Check Emails',
          ncolor: rojoClaro,
          category: 'Personal'),
      ToDo(
          id: '04',
          todoTitle: 'Hola1 Personal',
          todoText: 'Check Emails',
          ncolor: rojoClaro,
          category: 'Personal'),
      ToDo(
          id: '05',
          todoTitle: 'Hola2 Personal',
          todoText: 'Check Emails',
          ncolor: rojoClaro,
          category: 'Personal'),
      ToDo(
          id: '06',
          todoTitle: 'Hola3 Whitlist',
          todoText: 'Check Emails',
          ncolor: rojoClaro,
          category: 'Whitlist'),
      ToDo(
          id: '07',
          todoTitle: 'Hola4 Shopping',
          todoText: 'Check Emails',
          ncolor: rojoClaro,
          category: 'Shopping'),
    ];
  }
}
