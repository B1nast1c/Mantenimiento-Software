import 'package:flutter/material.dart';
import 'package:flutter_todo_app/screens/Schecks/new_check.dart';
import 'package:provider/provider.dart';
import '/../providers/provider.dart';
import '/../constants/colors.dart';
import '/../widgets/check_item.dart';
import 'package:flutter_todo_app/model/check.dart';

class CheckList extends StatefulWidget {
  const CheckList({Key? key}) : super(key: key);

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
    // ignore: non_constant_identifier_names
    var CheckVisibles = context.watch<Changes>().listCheckVisibles;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  color: Colors.white),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 40,
              ),
              child: Column(
                children: [
                  Column(children: [
                    Text(
                      _seeLanguage()
                          ? "Check List"
                          : "Lista Check", //Actualiza el titulo y el listado dependiendo de lo seleccionado
                      style: TextStyle(
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
                        _seeLanguage()
                            ? "Total quantity: $cantidad"
                            : "Cantidad total: $cantidad",
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
        margin: const EdgeInsets.only(top: 20),
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
        ));
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

  Widget _createTodo(Check todoo) {
    return checkItem(
      todo: todoo,
      onToDoChanged: _handleToDoChange,
      onDeleteItem: _deleteToDoItem,
    );
  }

  bool _seeLanguage() {
    if (context.read<Changes>().language == "ESP") {
      return false;
    }
    return true;
  }
}
