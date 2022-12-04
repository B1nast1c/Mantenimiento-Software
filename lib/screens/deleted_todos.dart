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
    var deletedTodosVisibles = context.watch<Changes>().deletedTodosVisibles;
    var deletedList = context.watch<Changes>().deletedTodos;
    _updateScreen(deletedTodosVisibles, deletedList);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          foregroundColor:
              context.read<Changes>().darkModes ? Colors.black : Colors.white,
          backgroundColor:
              context.read<Changes>().darkModes ? Colors.white : NegroSuave,
          elevation: 0,
        ),
        body: Container(
            decoration: BoxDecoration(
              color:
                  context.read<Changes>().darkModes ? Colors.white : NegroSuave,
            ),
            child: Column(children: [
              Column(children: [
                Center(
                  child: _seeLanguage()
                      ? Text(
                          'Deleted ToDos',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w500,
                              color: context.read<Changes>().darkModes
                                  ? Colors.black
                                  : Colors.white),
                        )
                      : Text(
                          'Notas eliminadas',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w500,
                              color: context.read<Changes>().darkModes
                                  ? Colors.black
                                  : Colors.white),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: searchBox(deletedList),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: const EdgeInsets.only(right: 15.0),
                      child: TextButton.icon(
                        icon: const Icon(Icons.delete),
                        label: Text(
                            _seeLanguage() ? 'Delete all' : 'Eliminar todos'),
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
                    for (DeletedToDo deletedTodo
                        in deletedTodosVisibles.reversed)
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
                _seeLanguage()
                    ? 'Remaining time: ${todoo.remainingTime}'
                    : 'Tiempo restante: ${todoo.remainingTime}',
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

  void _updateScreen(deletedTodosVisibles, deletedTodos) {
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

  void _runFilter(String enteredKeyword, List<DeletedToDo> list) {
    List<DeletedToDo> results = [];
    setState(() {});
    var listDeleted = context.read<Changes>().getDeletedTodos();
    if (enteredKeyword.isEmpty) {
      results = listDeleted;
    } else {
      results = listDeleted
          .where((item) =>
              item.todoTitle!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              item.todoText!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    context.read<Changes>().setListDeletedVisibles(results);
    print(results);
  }

  Widget searchBox(List<DeletedToDo> list) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value, list),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: _seeLanguage() ? 'Search' : 'Buscar',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  bool _seeLanguage() {
    if (context.read<Changes>().language == "ESP") {
      return false;
    }
    return true;
  }
}
