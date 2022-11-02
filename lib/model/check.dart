import 'package:flutter/material.dart';

class Check {
  String? id;
  String? todoTitle;
  //String? todoText; ¿Necesario?
  bool isDone;
  String? date;
  String? editdate;
  Color? ncolor;
  String? category;
  var datef;

  Check({
    required this.id,
    required this.todoTitle,
    //required this.todoText,
    required this.date,
    this.isDone = false,
    this.ncolor = Colors.white,
    required this.datef,
    //his.category = 'Uncategorized', ¿Llevaran categorías?
  });

  static List<Check> checkListP() {
    return [
      Check(
          id: '02',
          todoTitle: 'Check 1',
          //todoText: 'Check Emails',
          ncolor: const Color(0xffff9aa2),
          //category: 'Uncategorized'),
          date: "hoy :v",
          datef: DateTime.now()),
      Check(
          id: '03',
          todoTitle: 'Check Personal',
          //todoText: 'Check Emails',
          ncolor: const Color(0xffff9aa2),
          //category: 'Personal'),
          date: "hoy :v",
          datef: DateTime.now()),
    ];
  }
}
