import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/colors.dart';
import 'package:flutter_todo_app/model/deleted_todo.dart';
import 'package:flutter_todo_app/widgets/deleted_todo.dart';
import 'package:provider/provider.dart';

import '../model/todo.dart';
import '../providers/provider.dart';

class DeletedToDos extends StatefulWidget {
  const DeletedToDos({Key? key}) : super(key: key);
  @override
  State<DeletedToDos> createState() => _DeletedToDosState();
}

class _DeletedToDosState extends State<DeletedToDos> {
  late Timer countDown;

  @override
  Widget build(BuildContext context) {
    var deletedList = context.watch<Changes>().deletedTodos;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Container(
            color: Colors.white,
            child: Column(children: [
              Column(children: const [
                Center(
                  child: Text(
                    'Deleted ToDos',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ]),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                      ),
                    ),
                    for (DeletedToDo deletedTodo in deletedList.reversed)
                      _createTodo(deletedTodo),
                  ],
                ),
              )
            ])));
  }

  Widget _createTodo(DeletedToDo todoo) {
    startTimer(todoo);

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 20.0, bottom: 5),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Remaining time: ${todoo.remainingTime}',
              style: const TextStyle(
                  color: rojoIntenso, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DeletedToDoItem(todo: todoo)
      ],
    );
  }

  void startTimer(DeletedToDo todoo) {
    const timeInterval = Duration(seconds: 1);
    countDown = Timer.periodic(timeInterval, (Timer timer) {
      while (todoo.remainingTime > 0) {
        print(todoo.todoTitle.toString() + todoo.remainingTime.toString());
        todoo.remainingTime--;
      }
    });
  }
}
