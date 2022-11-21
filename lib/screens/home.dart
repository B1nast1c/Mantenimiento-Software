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
      backgroundColor:
          context.read<Changes>().darkModes ? Colors.white : Colors.black12,
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
                      style:  TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                        color: context.read<Changes>().darkModes ? Colors.black: Colors.white,
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
                        _LanguageQuantity(cantidad),
                        textAlign: TextAlign.right,
                        style:  TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                          color: context.read<Changes>().darkModes ? Colors.black: Colors.white,
                        ),
                      ),
                    ),
                  ]),
                  Expanded(
                    child: Card(
                      color: context.read<Changes>().darkModes
                          ? Colors.white
                          : Colors.black,
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
                      primary: context.read<Changes>().darkModes
                          ? Colors.white
                          : Colors.grey,
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
        color: context.read<Changes>().darkModes ? Colors.white: AppbarColor,
        alignment: Alignment.centerRight,
        child: Row(
          
          children: [
            DropdownButton(
              dropdownColor: context.read<Changes>().darkModes ? Colors.white: AppbarColor,
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
                            color: context.read<Changes>().darkModes ? Colors.white: AppbarColor,
                            alignment: Alignment.centerLeft, child: Icon(e,
                                   color: context.read<Changes>().darkModes ? Colors.black: Colors.white,)),
                      ))
                  .toList(),
              selectedItemBuilder: (BuildContext context) =>
                  options.map((e) => Center(child: Icon(e))).toList(),
            ),
            IconButton(
              icon: const Icon(Icons.sort),
              color: context.read<Changes>().darkModes ? Colors.black: Colors.white,
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
                  primary: context.read<Changes>().darkModes ? Colors.white: AppbarColor,
                  onPrimary: context.read<Changes>().darkModes ? rojoIntenso: Colors.white,
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
                  primary: context.read<Changes>().darkModes ? Colors.white: AppbarColor,
                  onPrimary: context.read<Changes>().darkModes ? rojoIntenso: Colors.white,
                  side: const BorderSide(
                    width: 1.0,
                    color: rojoIntenso,
                  )),
              onPressed: pickDateRange,
              child: Text(
                  '${dateRange.end.year}/${dateRange.end.month}/${dateRange.end.day}',
                  /*style: TextStyle(
                    fontWeight:  FontWeight.w700
                  ),*/),
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
          hintText: '',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: context.read<Changes>().darkModes ? Colors.white: AppbarColor, 
      iconTheme:  IconThemeData(color:context.read<Changes>().darkModes ?  Colors.black: Colors.white ),
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

  String _LanguageQuantity(int cantidad) {
    if (context.read<Changes>().language == "ESP") {
      return "Cantidad total: $cantidad";
    }
    return "Total quantity: $cantidad";
  }
}
