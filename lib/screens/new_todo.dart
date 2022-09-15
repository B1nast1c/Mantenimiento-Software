import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/category.dart';
import 'package:flutter_todo_app/widgets/category_picker.dart';
import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/color_picker.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({Key? key, required this.list, required this.listCat})
      : super(key: key);
  final List<ToDo> list;
  final List<CategoriaTodo> listCat;

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  Color _color = Colors.white;
  final _todoControllerTitle = TextEditingController();
  final _todoControllerContent = TextEditingController();
  int _categoryIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: rojoIntenso,
        appBar: AppBar(
          backgroundColor: rojoIntenso,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
                topRight: Radius.circular(60),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 40.0, horizontal: 10.0),
                      child: Text(
                        'Nueva Nota',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 30, bottom: 10),
                      child: const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Título',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w300),
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
                            hintText: 'Título',
                            hintStyle: const TextStyle(
                              color: tdGrey,
                            ),
                            fillColor: tdBGColor),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 30, bottom: 10, top: 20),
                      child: const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Descripción',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w300),
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
                            hintText: 'Descripción',
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
                      child: const Text(
                        'Elige una categoría para la nota',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        buildPicker();
                      },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 5.0)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: const BorderSide(
                                color: rojoIntenso,
                                width: 2.0,
                              ),
                            ),
                          )),
                      child: _categoryIndex == -1
                          ? const Text('Seleccionar Categoría',
                              style:
                                  TextStyle(color: rojoIntenso, fontSize: 16))
                          : Text(
                              widget.listCat[_categoryIndex].catText.toString(),
                              style: const TextStyle(
                                  color: rojoIntenso, fontSize: 16)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 20.0, left: 30.0),
                      child: const Text(
                        'Escoge un color para la nota',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
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
                          _todoControllerContent.text);
                      Navigator.pop(context, widget.list);
                    },
                  ),
                )),
              ],
            )));
  }

  void _addToDoItem(String toDoTitle, String toDoContent) {
    setState(() {
      widget.list.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoTitle: toDoTitle,
          todoText: toDoContent,
          ncolor: _color,
          category: widget.listCat[_categoryIndex].catText.toString()));
    });
    _todoControllerTitle.clear();
    _todoControllerContent.clear();
  }

  void updateCategoryIndex(int index) {
    setState(() {
      _categoryIndex = index;
    });
  }

  void buildPicker() async {
    final data = await Navigator.push(
      //Navigator.pop retorna un objeto de tipo final
      context,
      CupertinoModalPopupRoute(
          //Generator
          builder: (BuildContext builder) =>
              CategoryPicker(listCat: widget.listCat)),
    );
    updateCategoryIndex(data);
  }
}
