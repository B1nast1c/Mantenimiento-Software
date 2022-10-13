import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/colors.dart';
import 'package:flutter_todo_app/model/deleted_todo.dart';
import 'package:flutter_todo_app/widgets/deleted_todo_item.dart';
import 'package:provider/provider.dart';

import '../providers/provider.dart';

//========================================//
//                                        //
//    PANTALLA PAPELERA DE RECICLAJE      //
//                                        //
//========================================//

//BUGS:
//ERROR DE EXCEPCIONES CUANDO HAY UNA NOTA EN LA PAPELERA DE RECICLAJE

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
    _updateScreen();
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
              Column(children: [
                const Center(
                  child: Text(
                    'Deleted ToDos',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: const EdgeInsets.only(right: 15.0),
                      child: TextButton.icon(
                        icon: const Icon(Icons.delete),
                        label: const Text('Delete all'),
                        style: TextButton.styleFrom(primary: Colors.red),
                        onPressed: () {
                          deleteAllToDos();
                        },
                      ),
                    )),
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
    if (todoo.dead == false) {
      context.read<Changes>().purgeTodo(todoo);
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
          DeletedToDoItem(
            todo: todoo,
            removeToDo: removeToDo,
            restoreToDo: restoreToDo,
          )
        ],
      );
    }
    return Container();
  }

  void _updateScreen() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (mounted) {
        setState(() {
          context.read<Changes>().cleanDeletes();
        });
      }
    });
  }

  void removeToDo(DeletedToDo deleted) {
    //Aqui van las modificaciones de eliminación
    context.read<Changes>().removeToDoItem(deleted);
  }

  void restoreToDo(DeletedToDo deleted) {
    //Aqui van las modificaciones de eliminación
    context.read<Changes>().restoreDeleted(deleted);
    context.read<Changes>().removeToDoItem(deleted);
  }

  void deleteAllToDos() {
    context.read<Changes>().deleteAllToDos();
  }
}
