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

  void setListTodo(List<ToDo> list) {
    listTodo = list;
    notifyListeners(); //notificamos a los widgets que esten escuchando el stream.
  }

  void sortTodos(List<ToDo> toSort) {
    toSort.sort(
        (a, b) => b.todoTitle.toString().compareTo(a.todoTitle.toString()));
    setListTodo(toSort);
    notifyListeners();
  }

  void deleteTodo(ToDo todo) {
    listTodo.removeWhere((item) => item.id == todo.id);
    notifyListeners();
  }

  void setCategories(List<CategoriaTodo> list) {
    listCategories = list;
    notifyListeners();
  }

  void setTitle(String title) {
    pageTitle = title;
    notifyListeners();
  }

  void addDeleted(ToDo todo) {
    DeletedToDo deleted = DeletedToDo(
        id: todo.id, todoTitle: todo.todoTitle, todoText: todo.todoText);
    deletedTodos.add(deleted);
    notifyListeners();
  }
}
