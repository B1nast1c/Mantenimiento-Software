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

//========================================//
//                                        //
//           PANTALLA PRINCIPAL           //
//                                        //
//========================================//

//BUGS:
//
//
class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String? title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  final categoryList = CategoriaTodo.fullCategory();
  DateTimeRange dateRange =
      DateTimeRange(start: DateTime(2022, 9, 5), end: DateTime(2023, 2, 26));

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var todosList = context.watch<Changes>().listTodo;
    var title = context.watch<Changes>().pageTitle;
    var cantidad = context.watch<Changes>().cantidad;
    var todosVisibles = context.watch<Changes>().listTodoVisibles;
    return Scaffold(
      backgroundColor: Colors.white,
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
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    searchBox(),
                    dateFilter(),
                    Container(
                      height: 30.0,
                      margin: const EdgeInsets.only(
                        top: 10,
                      ),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Total quantity: $cantidad",
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ]),
                  Expanded(
                    child: Card(
                      color: Colors.white,
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      child: ListView(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 10,
                              bottom: 20,
                            ),
                          ),
                          for (ToDo todoo in todosVisibles.reversed)
                            _createTodo(todoo),
                        ],
                      ),
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
                      primary: Colors.white,
                      minimumSize: const Size(60, 60),
                      elevation: 5,
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

  void _dateFilter(var dateActual, DateTimeRange dateRango) {
    List<ToDo> results = [];
    setState(() {});
    List<ToDo> listaAct2 = context.read<Changes>().getTodos();
    if (dateRango == null) {
      results = listaAct2;
    } else {
      results = listaAct2
          .where((item) =>
              item.datef.isBefore(dateRango.end) &&
              item.datef.isAfter(dateRango.start))
          .toList();
    }
    context.read<Changes>().setListTodoVisibles(results);
  }

  void _runFilter(String enteredKeyword, List<ToDo> listaAct) {
    List<ToDo> results = [];
    setState(() {});
    List<ToDo> listaAct2 = context.read<Changes>().getTodos();
    if (enteredKeyword.isEmpty) {
      results = listaAct2;
    } else {
      results = listaAct2
          .where((item) =>
              item.todoTitle!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              item.todoText!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    context.read<Changes>().setListTodoVisibles(
        results); //Filtrar los resultados de la lista del provider
  }

  Widget managementIcons() {
    List<IconData> options = [
      Icons.abc,
      Icons.format_bold,
      Icons.format_italic,
      Icons.add,
      Icons.minimize
    ];

    return Container(
        alignment: Alignment.centerRight,
        child: Row(
          children: [
            DropdownButton(
              value: options[0],
              onChanged: (value) {
                int index = //Ver el estilo asignado
                    options.indexWhere((element) => element == value) + 1;
                context.read<Changes>().setStyle(index);
              },
              underline: Container(),
              icon: const Icon(
                Icons.settings,
              ),
              isExpanded: false,
              items: options
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Container(
                            alignment: Alignment.centerLeft, child: Icon(e)),
                      ))
                  .toList(),
              selectedItemBuilder: (BuildContext context) =>
                  options.map((e) => Center(child: Icon(e))).toList(),
            ),
            IconButton(
              icon: const Icon(Icons.sort),
              color: Colors.black,
              iconSize: 25.0,
              onPressed: () {
                context.read<Changes>().sortTodos();
              },
            ),
          ],
        ));
  }

  Widget dateFilter() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: rojoIntenso,
                  side: const BorderSide(
                    width: 1.0,
                    color: rojoIntenso,
                  )),
              onPressed: pickDateRange,
              child: Text(
                  '${dateRange.start.year}/${dateRange.start.month}/${dateRange.start.day}'),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: rojoIntenso,
                  side: const BorderSide(
                    width: 1.0,
                    color: rojoIntenso,
                  )),
              onPressed: pickDateRange,
              child: Text(
                  '${dateRange.end.year}/${dateRange.end.month}/${dateRange.end.day}'),
            ),
          ),
        ],
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));

    if (newDateRange == null) return;

    _dateFilter(todosList, newDateRange);
    setState(() => dateRange = newDateRange);
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
        onChanged: (value) => _runFilter(value, todosList),
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
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
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      actions: <Widget>[
        managementIcons(),
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
