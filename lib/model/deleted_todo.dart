import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_todo_app/main.dart';
import '../constants/colors.dart';

class DeletedToDo {
  String? id;
  String? todoTitle;
  String? todoText;
  String? date;
  String? editdate;
  Color? ncolor;
  String? category;
  int remainingTime;
  bool dead;
  String? language;

  DeletedToDo(
      {required this.id,
      required this.todoTitle,
      required this.todoText,
      this.ncolor = rojoClaro,
      this.remainingTime = 20, //Pruebas de momento
      this.category = 'Deleted',
      this.dead = false,
      required this.language,
      required date});

  void startTimer() {
    const timeInterval = Duration(seconds: 1);
    Timer.periodic(timeInterval, (Timer timer) {
      remainingTime--;

      if (remainingTime == 10) {
        //Notificacion que falten 10 segundos
        language == "ENG"
            ? showNotification("10 seconds left!",
                "Watch out!, your note '$todoTitle' will be deleted in 10 seconds")
            : showNotification("¡10 segundos restantes!",
                "¡Cuidado!, la nota '$todoTitle' será eliminada en 10 segundos");
      }

      if (remainingTime <= 0) {
        //Notificacion eliminación total :D
        timer.cancel();
        dead = true;
        language == "ENG" //LENGUAJE
            ? showNotification("We're done XD",
                "Your note '$todoTitle' has been pertmanently deleted :(")
            : showNotification("Lo sentimos",
                "La nota '$todoTitle' ha sido eliminada permanentemente :(");
      }
    });
  }
}

void showNotification(String nombre, String detalle) async {
  AndroidNotificationDetails androidDetails = const AndroidNotificationDetails(
      "notas-eliminadas", "Notas Eliminadas",
      priority: Priority.max, importance: Importance.max);

  NotificationDetails notificationDetails =
      NotificationDetails(android: androidDetails);

  await notificationsPlugin.show(
      0, nombre, detalle, notificationDetails); //Llamado a la variable global
}
