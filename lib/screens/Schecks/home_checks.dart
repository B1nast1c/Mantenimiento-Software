import 'package:flutter/material.dart';
import 'package:flutter_todo_app/screens/Schecks/new_check.dart';
import 'package:provider/provider.dart';
import '/../providers/provider.dart';
import '/../constants/colors.dart';
import '/../widgets/check_item.dart';
import 'package:flutter_todo_app/model/check.dart';

class CheckList extends StatefulWidget {
  CheckList({Key? key}) : super(key: key);

  @override
  State<CheckList> createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  final todosCheck = Check.checkListP();
  //final categoryList = CategoriaTodo.fullCategory();
  DateTimeRange dateRange =
      DateTimeRange(start: DateTime(2022, 9, 5), end: DateTime(2023, 2, 26));

  @override
  Widget build(BuildContext context) {
    var todosCheck = context.watch<Changes>().listCheck;
    var title = context.watch<Changes>().pageTitleCheck;
    var cantidad = context.watch<Changes>().cantidadCheck;
    var CheckVisibles = context.watch<Changes>().listCheckVisibles;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: tdBGColor,
      appBar: AppBar(
        backgroundColor: rojoIntenso,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
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
                      "Check List", //Actualiza el titulo y el listado dependiendo de lo seleccionado
                      style: const TextStyle(
                        fontSize: 30,
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
                      color: tdBGColor,
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
                          for (Check todoo in CheckVisibles.reversed)
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
                        MaterialPageRoute(builder: (context) => NewCheck()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: tdBGColor,
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

  void _handleToDoChange(Check todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(Check todo) {
    //Aqui van las modificaciones de eliminación
    context.read<Changes>().deleteCheck(todo);
  }

  Widget dateFilter() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              child: Text(
                  '${dateRange.start.year}/${dateRange.start.month}/${dateRange.start.day}'),
              onPressed: pickDateRange,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: ElevatedButton(
              child: Text(
                  '${dateRange.end.year}/${dateRange.end.month}/${dateRange.end.day}'),
              onPressed: pickDateRange,
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

    _dateFilter(todosCheck, newDateRange);
    setState(() => dateRange = newDateRange);
  }

  void _dateFilter(var dateActual, DateTimeRange dateRango) {
    List<Check> results = [];
    setState(() {});
    List<Check> listaAct2 = context.read<Changes>().getChecks();
    if (dateRango == null) {
      results = listaAct2;
    } else {
      results = listaAct2
          .where((item) =>
              item.datef.isBefore(dateRango.end) &&
              item.datef.isAfter(dateRango.start))
          .toList();
    }
    context.read<Changes>().setListCheckVisibles(results);
  }

  void _runFilter(String enteredKeyword, List<Check> listaAct) {
    List<Check> results = [];
    setState(() {});
    List<Check> listaAct2 = context.read<Changes>().getChecks();
    if (enteredKeyword.isEmpty) {
      results = listaAct2;
    } else {
      results = listaAct2
          .where((item) => item.todoTitle!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    context.read<Changes>().setListCheckVisibles(
        results); //Filtrar los resultados de la lista del provider
  }

  Widget sortingIcon() {
    return Container(
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: const Icon(Icons.sort),
        color: Colors.black,
        iconSize: 25.0,
        onPressed: () {
          context.read<Changes>().sortTodos();
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
        onChanged: (value) => _runFilter(value, todosCheck),
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

  Widget _createTodo(Check todoo) {
    //Categorias que se muestran en la pantalla

    //  if (globals.CategoriasActivas.contains(todoo.category)) {
    return checkItem(
      todo: todoo,
      onToDoChanged: _handleToDoChange,
      onDeleteItem: _deleteToDoItem,
      //category: categoryList,
    );
  }
  //   return Container();
  //}
}
