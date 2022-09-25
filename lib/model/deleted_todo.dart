import 'dart:async';

import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'package:provider/provider.dart';
import '../providers/provider.dart';

class DeletedToDo {
  String? id;
  String? todoTitle;
  String? todoText;
  Color? ncolor;
  String? category;
  int remainingTime;
  bool dead;

  void startTimer() {
    const timeInterval = Duration(seconds: 1);
    print('Comenzo');
    Timer.periodic(timeInterval, (Timer timer) {
      print(todoTitle.toString() + ' ' + remainingTime.toString());
      remainingTime--;
      if (remainingTime == 0) {
        timer.cancel();
        dead = true;
      }
    });
  }

  DeletedToDo(
      {required this.id,
      required this.todoTitle,
      required this.todoText,
      this.ncolor = rojoClaro,
      this.remainingTime = 20,
      this.category = 'Deleted',
      this.dead = false});
}
