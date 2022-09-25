import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_todo_app/global/globals.dart';
import 'package:flutter_todo_app/model/deleted_todo.dart';
import 'package:flutter_todo_app/model/todo.dart';

import '../model/category.dart';

//Gestor de estados que ayuda a la actualización de las cosas dentro de la interfaz

class Changes with ChangeNotifier {
  List<ToDo> listTodo = ToDo.todoList();
  List<CategoriaTodo> listCategories = CategoriaTodo.fullCategory();
  String pageTitle = titulo;
  List<DeletedToDo> deletedTodos = []; //Eliminados sin tiempo de espera
  List<DeletedToDo> listPurgeTodos = []; //Para eliminar de un "golpe"
  bool order = true; //Para ordenar ascendente o descentente
  void setListTodo(List<ToDo> list) {
    listTodo = list;
    notifyListeners(); //notificamos a los widgets que esten escuchando el stream.
  }

  void sortTodos() {
    listTodo.sort(
        (a, b) => a.todoTitle.toString().compareTo(b.todoTitle.toString()));

    if (order == true) {
      order = false;
    } else {
      listTodo = listTodo.reversed.toList();
      order = true;
    }

    notifyListeners();
  }

  void deleteTodo(ToDo todo) {
    listTodo.removeWhere((item) => item.id == todo.id);
    notifyListeners();
  }

  void purgeTodo(DeletedToDo deleted) {
    if (deleted.remainingTime <= 1) {
      listPurgeTodos.add(deleted);
    }
    notifyListeners();
  }

  void removeToDoItem(DeletedToDo deleted) {
    deletedTodos.removeWhere((item) => item.id == deleted.id);
    notifyListeners();
  }

  void setCategories(List<CategoriaTodo> list) {
    listCategories = list;
    notifyListeners();
  }

  void changeUsedTrue() {
    //Una vez que seleccionamos la categoria vamos al home para actualizar las categorias
    notifyListeners();
  }

  void setTitle(String title) {
    pageTitle = title;
    notifyListeners();
  }

  void addDeleted(ToDo todo) {
    DeletedToDo deleted = DeletedToDo(
        id: todo.id,
        todoTitle: todo.todoTitle,
        todoText: todo.todoText,
        ncolor: todo.ncolor,
        category: todo.category);
    deletedTodos.add(deleted);
    deleted.startTimer();
    notifyListeners();
  }

  void restoreDeleted(DeletedToDo todo) {
    ToDo deleted = ToDo(
        id: todo.id,
        todoTitle: todo.todoTitle,
        todoText: todo.todoText,
        ncolor: todo.ncolor,
        category: todo.category);
    print('fUNCIONA');
    print(deleted.todoTitle);
    listTodo.add(deleted);
    notifyListeners();
  }

  void cleanDeletes() {
    deletedTodos.removeWhere((item) => listPurgeTodos.contains(item));
    notifyListeners();
  }
/* Intento fallido para actualizar pantalla (por ahora xD)
  void updateTime(DeletedToDo deleted) {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
    });
    deletedTodos.removeWhere((item) => item.id == deleted.id);
    notifyListeners();
  }*/
}
