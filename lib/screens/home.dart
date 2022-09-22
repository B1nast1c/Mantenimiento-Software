import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/category.dart';
import 'package:provider/provider.dart';

import '../model/todo.dart';
import '../constants/colors.dart';
import '../providers/provider.dart';
import '../widgets/todo_item.dart';
import '../widgets/sidebar_menu.dart';
import '../screens/new_todo.dart';
import '../global/globals.dart' as globals;

//VERIFICAR POR QUE EL SORTING NO FUNCIONA :'v (De momento existe ese error nomas)

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String? title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  final categoryList = CategoriaTodo.fullCategory();

  @override
  Widget build(BuildContext context) {
    var todosList = context.watch<Changes>().listTodo;
    var title = context.watch<Changes>().pageTitle;

    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      drawer: const sidebarMenu(),
      body: Stack(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 40,
              ),
              child: Column(
                children: [
                  Column(children: [
                    Text(
                      title, //Actualiza el titulo y el listado dependiendo de lo seleccionado
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    searchBox(),
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
                        for (ToDo todoo in todosList.reversed)
                          _createTodo(todoo),
                      ],
                    ),
                  )
                ],
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin:
                      const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NewTodo()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: weso,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(ToDo todo) {
    //Aqui van las modificaciones de eliminación
    context.read<Changes>().deleteTodo(todo);
    context.read<Changes>().addDeleted(todo);
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) =>
              item.todoTitle!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              item.todoText!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    context
        .read<Changes>()
        .setListTodo(results); //Filtrar los resultados de la lista del provider
  }

  Widget sortingIcon() {
    return Container(
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: const Icon(Icons.sort),
        color: Colors.black,
        iconSize: 25.0,
        onPressed: () {
          context.read<Changes>().sortTodos(todosList);
        },
      ),
    );
  }

  Widget searchBox() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
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
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      actions: <Widget>[
        sortingIcon(),
      ],
    );
  }

  Widget _createTodo(ToDo todoo) {
    //Categorias que se muestran en la pantalla
    if (globals.CategoriasActivas.contains(todoo.category)) {
      return ToDoItem(
        todo: todoo,
        onToDoChanged: _handleToDoChange,
        onDeleteItem: _deleteToDoItem,
        category: categoryList,
      );
    }
    return Container();
  }
}
