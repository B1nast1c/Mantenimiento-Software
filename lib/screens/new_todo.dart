import 'package:flutter/material.dart';
import 'package:flutter_todo_app/widgets/category_picker.dart';
import 'package:provider/provider.dart';
import '../model/todo.dart';
import '../constants/colors.dart';
import '../providers/provider.dart';
import '../widgets/color_picker.dart';
import 'package:intl/intl.dart';

String date = DateFormat.yMMMEd().format(DateTime.now());
//========================================//
//                                        //
//          PANTALLA CREAR NOTAS          //
//                                        //
//========================================//

//BUGS:
//

class NewTodo extends StatefulWidget {
  const NewTodo({Key? key}) : super(key: key);

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  Color _color = Colors.white;
  final _todoControllerTitle = TextEditingController();
  final _todoControllerContent = TextEditingController();
  String? _category;

  @override
  Widget build(BuildContext context) {
    var categoriesList = context.watch<Changes>().listCategories;
    var todoList = context.watch<Changes>().listTodo;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: weso,
        appBar: AppBar(
          backgroundColor: weso,
          foregroundColor: context.read<Changes>().darkModes ? Colors.black: Colors.white,
          elevation: 0,
        ),
        body: Container(
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
                topRight: Radius.circular(60),
              ),
              color: context.read<Changes>().darkModes ? Colors.white: NegroSuave,
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.0),
                      child: Text(
                        _seeLanguage() ? 'Add new ToDo' : 'Agregar nueva nota',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: context.read<Changes>().darkModes ? Colors.black: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 30, bottom: 10),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          _seeLanguage() ? 'Title' : 'Título',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300,
                              color: context.read<Changes>().darkModes ? Colors.black: Colors.white,),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        onChanged: (value) => _todoControllerTitle.text =
                            value, //Actualización del valor del input
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 25.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100.0),
                              borderSide: const BorderSide(
                                  color: tdBGColor, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: rojoIntenso, width: 1.0),
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            hintText: _seeLanguage()
                                ? 'Enter the title'
                                : 'Ingresa un título',
                            hintStyle: const TextStyle(
                              color: tdGrey,
                            ),
                            fillColor: tdBGColor),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 30, bottom: 10, top: 20),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          _seeLanguage() ? 'Description' : 'Descripción',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300,
                              color: context.read<Changes>().darkModes ? Colors.black: Colors.white,),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        onChanged: (value) => _todoControllerContent.text =
                            value, //Actualización del valor del input
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 25.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100.0),
                              borderSide: const BorderSide(
                                  color: tdBGColor, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: rojoIntenso, width: 1.0),
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            hintText:
                                _seeLanguage() ? 'Description' : 'Descripción',
                            hintStyle: const TextStyle(
                              color: tdGrey,
                            ),
                            fillColor: tdBGColor),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          top: 20.0, left: 30.0, bottom: 15.0),
                      child: Text(
                        _seeLanguage()
                            ? 'Choose a category for your ToDo'
                            : 'Escoge una categoría para la nota',
                        style: TextStyle(
                          fontSize: 16.5,
                          fontWeight: FontWeight.w400,
                          color: context.read<Changes>().darkModes ? Colors.black: Colors.white,
                        ),
                      ),
                    ),
                    CategoryPicker(
                      listCat: categoriesList,
                      onChanged: (String? newCategory) {
                        setState(() => _category = newCategory);
                      },
                      category: 'null',
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 20.0, left: 30.0),
                      child: Text(
                        _seeLanguage()
                            ? 'Choose a color for your ToDo'
                            : 'Escoge un color para la nota',
                        style: TextStyle(
                          fontSize: 16.5,
                          fontWeight: FontWeight.w400,
                          color: context.read<Changes>().darkModes ? Colors.black: Colors.white,
                        ),
                      ),
                    ),
                    ColorPicker(
                        onSelectedColor: (value) {
                          setState(() {
                            _color = value;
                          });
                        },
                        chosenColor: Colors.white),
                  ],
                ),
                Expanded(
                    child: Container(
                  alignment: Alignment.bottomRight,
                  margin: const EdgeInsets.only(right: 25.0, bottom: 25.0),
                  child: IconButton(
                    icon: const Icon(Icons.check),
                    color: Colors.green,
                    iconSize: 35.0,
                    onPressed: () {
                      _addToDoItem(_todoControllerTitle.text,
                          _todoControllerContent.text, todoList);
                      Navigator.pop(context);
                    },
                  ),
                )),
              ],
            )));
  }

  void _addToDoItem(String toDoTitle, String toDoContent, List<ToDo> list) {
    _category ??= 'Uncategorized';

    ToDo nota = ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoTitle: toDoTitle,
        todoText: toDoContent,
        ncolor: _color,
        category: _category,
        datef: DateTime.now());
    nota.date = date;
    list.add(nota);
    context.read<Changes>().setListTodo(list);

    _todoControllerTitle.clear();
    _todoControllerContent.clear();
  }

  bool _seeLanguage() {
    if (context.read<Changes>().language == "ESP") {
      return false;
    }
    return true;
  }
}
