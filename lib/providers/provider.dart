import 'package:flutter/foundation.dart';
import 'package:flutter_todo_app/global/globals.dart';
import 'package:flutter_todo_app/model/deleted_todo.dart';
import 'package:flutter_todo_app/model/todo.dart';
import 'package:flutter_todo_app/model/check.dart';

import '../model/category.dart';

//Gestor de estados que ayuda a la actualización de las cosas dentro de la interfaz

class Changes with ChangeNotifier {
  List<ToDo> listTodo = ToDo.todoList();
  int cantidad = ToDo.todoList().length;
  List<ToDo> listTodoVisibles = ToDo.todoList();
  List<CategoriaTodo> listCategories = CategoriaTodo.fullCategory();
  String pageTitle = titulo;
  List<DeletedToDo> deletedTodos = []; //Eliminados sin tiempo de espera
  List<DeletedToDo> deletedTodosVisibles = []; //Eliminados sin tiempo de espera
  List<DeletedToDo> listPurgeTodos = []; //Para eliminar de un "golpe"
  bool order = true; //Para ordenar ascendente o descentente

  List<Check> listCheck = Check.checkListP();
  int cantidadCheck = Check.checkListP().length;
  List<Check> listCheckVisibles = Check.checkListP();
  String pageTitleCheck = titulo;
  bool orderCheck = true;

  int noteStyle = 0;

  /*---  Para controlar los textos ---*/
  String language = "ENG";
  String tLanguage = "English";
  String taCategory = "Add Category";
  String tAll = "All";
  String tCheckList = "CheckList";
  String tTrashCan = "TrashCan";
  String tDarkMode = "DarkMode";
  /* ------------------------- */

  /*---  Para el modo oscuro ---*/

  bool darkModes = false;

  void setStyle(int style) {
    noteStyle = style;
    notifyListeners();
  }

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

  void setListDeletedVisibles(List<DeletedToDo> list) {
    deletedTodosVisibles = list;
    notifyListeners(); //notificamos a los widgets que esten escuchando el stream.
  }

  void setListDeleted(List<DeletedToDo> list) {
    deletedTodosVisibles = list;
    notifyListeners(); //notificamos a los widgets que esten escuchando el stream.
  }

  List<ToDo> getTodos() {
    return listTodo;
  }

  List<DeletedToDo> getDeletedTodos() {
    return deletedTodos;
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
    deletedTodosVisibles = deletedTodos;
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

  void aplicarCambio(ToDo todo) {
    //Una vez que seleccionamos la categoria vamos al home para actualizar las categorias
    //listTodoVisibles = listTodo;
    listTodo.removeWhere((item) => item.id == todo.id);
    notifyListeners();
  }

  void setTitle(String title) {
    pageTitle = changeTitleLanguage(title);
    resetCantidad();
    notifyListeners();
  }

  void addDeleted(ToDo todo) {
    DeletedToDo deleted = DeletedToDo(
      id: todo.id,
      todoTitle: todo.todoTitle,
      todoText: todo.todoText,
      date: todo.date,
      ncolor: todo.ncolor,
      category: todo.category,
    );
    deleted.date = todo.date;
    deleted.editdate = todo.editdate;
    deletedTodos.add(deleted);
    deletedTodosVisibles = deletedTodos;
    notifyListeners();
    deleted.startTimer(); //para testear la busqueda
  }

  void restoreDeleted(DeletedToDo todo) {
    ToDo deleted = ToDo(
        id: todo.id,
        todoTitle: todo.todoTitle,
        todoText: todo.todoText,
        ncolor: todo.ncolor,
        category: todo.category,
        datef: DateTime.now());
    deleted.date = todo.date;
    deleted.editdate = todo.editdate;
    listTodo.add(deleted);
    listTodoVisibles = listTodo;

    resetCantidad();
    notifyListeners();
  }

  void deleteAllToDos() {
    deletedTodos.clear();
    deletedTodosVisibles = deletedTodos;
    notifyListeners();
  }

  void cleanDeletes() {
    if (listPurgeTodos.isNotEmpty) {
      deletedTodos.removeWhere((item) => listPurgeTodos.contains(item));
      listPurgeTodos = [];
    }

    notifyListeners();
  }

  void DeleteRepeated() {
    //ids.toSet().toList();
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

  //CHECKS

  void setListCheck(List<Check> list) {
    listCheck = list;
    listCheckVisibles = list;
    resetCantidadCheck();
    notifyListeners(); //notificamos a los widgets que esten escuchando el stream.
  }

  void setListCheckVisibles(List<Check> list) {
    listCheckVisibles = list;
    resetCantidadCheck();
    notifyListeners(); //notificamos a los widgets que esten escuchando el stream.
  }

  List<Check> getChecks() {
    return listCheck;
  }

  void sortChecks() {
    listCheck.sort(
        (a, b) => a.todoTitle.toString().compareTo(b.todoTitle.toString()));

    if (orderCheck == true) {
      orderCheck = false;
    } else {
      listCheck = listCheck.reversed.toList();
      orderCheck = true;
    }
    listCheckVisibles = listCheck;
    notifyListeners();
  }

  void editCheck(Check todo) {
    listCheck.removeWhere((item) => item.id == todo.id);
    listCheck.add(todo);
    listCheckVisibles = listCheck;
    notifyListeners();
  }

  void deleteCheck(Check todo) {
    listCheck.removeWhere((item) => item.id == todo.id);
    listCheckVisibles = listCheck;
    resetCantidadCheck();
    notifyListeners();
  }

  void resetCantidadCheck() {
    cantidadCheck = listCheckVisibles.length;
    notifyListeners();
  }

  void changeLanguage() {
    if (language == "ENG") {
      language = "ESP";
      tLanguage = "Español";
      tDarkMode = "Modo Oscuro";
      taCategory = "Añadir Categoria";
      tAll = "Todos";
      tCheckList = "Lista";
      tTrashCan = "Papelera";
    } else if (language == "ESP") {
      language = "ENG";
      tLanguage = "English";
      tDarkMode = "Dark Mode";
      taCategory = "Add Category";
      tAll = "All";
      tCheckList = "CheckList";
      tTrashCan = "TrashCan";
    }

    notifyListeners();
  }

  String changeTitleLanguage(String title) {
    if (language == "ESP") {
      if (title == "Shopping") {
        return "Compras";
      } else if (title == "Learn") {
        return "Estudios";
      } else if (title == "Personal") {
        return "Personal";
      } else if (title == "Wishlist") {
        return "Deseos";
      } else if (title == "Work") {
        return "Trabajo";
      } else if (title == "All Todos") {
        return "Todas las notas";
      }
    }

    return title;
  }

  void changeTheme() {
    if (darkModes == false) {
      darkModes = true;
    } else if (darkModes == true) {
      darkModes = false;
    }

    notifyListeners();
  }
}
