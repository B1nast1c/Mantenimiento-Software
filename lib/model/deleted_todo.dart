import 'dart:async';

import 'package:flutter/material.dart';
import '../constants/colors.dart';

class DeletedToDo {
  String? id;
  String? todoTitle;
  String? todoText;
  Color? ncolor;
  String? category;
  int remainingTime;
  bool dead;

  DeletedToDo(
      {required this.id,
      required this.todoTitle,
      required this.todoText,
      this.ncolor = rojoClaro,
      this.remainingTime = 100, //Pruebas de momento
      this.category = 'Deleted',
      this.dead = false});

  void startTimer() {
    const timeInterval = Duration(seconds: 1);
    Timer.periodic(timeInterval, (Timer timer) {
      remainingTime--;
      if (remainingTime == 0) {
        timer.cancel();
        dead = true;
      }
    });
  }
}
