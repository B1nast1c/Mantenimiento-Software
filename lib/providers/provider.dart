import 'package:flutter/foundation.dart';
import 'package:flutter_todo_app/global/globals.dart';
import 'package:flutter_todo_app/model/deleted_todo.dart';
import 'package:flutter_todo_app/model/todo.dart';

import '../model/category.dart';

//Gestor de estados que ayuda a la actualización de las cosas dentro de la interfaz

class Changes with ChangeNotifier {
  List<ToDo> listTodo = ToDo.todoList();
  int cantidad = ToDo.todoList().length;
  List<ToDo> listTodoVisibles = ToDo.todoList();
  List<CategoriaTodo> listCategories = CategoriaTodo.fullCategory();
  String pageTitle = titulo;
  List<DeletedToDo> deletedTodos = []; //Eliminados sin tiempo de espera
  List<DeletedToDo> listPurgeTodos = []; //Para eliminar de un "golpe"
  bool order = true; //Para ordenar ascendente o descentente
  void setListTodo(List<ToDo> list) {
    listTodo = list;
    listTodoVisibles = list;
    resetCantidad();
    notifyListeners(); //notificamos a los widgets que esten escuchando el stream.
  }

  void setListTodoVisibles(List<ToDo> list) {
    listTodoVisibles = list;
    resetCantidad();
    notifyListeners(); //notificamos a los widgets que esten escuchando el stream.
  }

  List<ToDo> getTodos() {
    return listTodo;
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
    listTodoVisibles = listTodo;
    notifyListeners();
  }

  void editTodo(ToDo todo) {
    listTodo.removeWhere((item) => item.id == todo.id);
    listTodo.add(todo);
    listTodoVisibles = listTodo;
    notifyListeners();
  }

  void deleteTodo(ToDo todo) {
    listTodo.removeWhere((item) => item.id == todo.id);
    listTodoVisibles = listTodo;
    resetCantidad();
    notifyListeners();
  }

  void purgeTodo(DeletedToDo deleted) {
    //Para que sirve esto?, esto es lo que causa la excepción
    if (deleted.remainingTime < 1) {
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
    resetCantidad();
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
    notifyListeners();
    deleted.startTimer();
  }

  void restoreDeleted(DeletedToDo todo) {
    ToDo deleted = ToDo(
        id: todo.id,
        todoTitle: todo.todoTitle,
        todoText: todo.todoText,
        ncolor: todo.ncolor,
        category: todo.category);
    listTodo.add(deleted);
    listTodoVisibles = listTodo;
    resetCantidad();
    notifyListeners();
  }

  void cleanDeletes() {
    deletedTodos.removeWhere((item) => listPurgeTodos.contains(item));
    notifyListeners();
  }

  void resetCantidad() {
    cantidad = listTodoVisibles
        .where((e) => CategoriasActivas.contains(e.category))
        .length;
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
