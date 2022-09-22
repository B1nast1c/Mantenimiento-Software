import 'package:flutter/material.dart';
import '../constants/colors.dart';

class DeletedToDo {
  String? id;
  String? todoTitle;
  String? todoText;
  Color? ncolor;
  String? category;
  int remainingTime;

  DeletedToDo(
      {required this.id,
      required this.todoTitle,
      required this.todoText,
      this.ncolor = rojoClaro,
      this.remainingTime = 10,
      this.category = 'Deleted'});
}
