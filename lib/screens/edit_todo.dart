import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/category.dart';
import 'package:flutter_todo_app/model/todo.dart';
import '../constants/colors.dart';
import '../widgets/category_picker.dart';
import '../widgets/color_picker.dart';
import 'package:provider/provider.dart';
import '../providers/provider.dart';
import 'package:intl/intl.dart';

String editdate = DateFormat.yMMMEd().format(DateTime.now());
//========================================//
//                                        //
//       PANTALLA EDICION DE NOTAS        //
//                                        //
//========================================//

//BUGS:
//
class EditTodo extends StatefulWidget {
  const EditTodo({Key? key, required this.item, required this.category})
      : super(key: key);
  final ToDo item;
  final List<CategoriaTodo> category;

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  Color _color = Colors.white;
  late TextEditingController _todoControllerTitle, _todoControllerContent;
  late String selectedCat;

  @override
  void initState() {
    super.initState();
    _todoControllerTitle = TextEditingController(text: widget.item.todoTitle);
    _todoControllerContent = TextEditingController(text: widget.item.todoText);
    selectedCat = widget.item.category.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: weso,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(250),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        _seeLanguage() ? 'Edit ToDo' : "Editar nota",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              _seeLanguage()
                                  ? 'Created at: ${widget.item.date}'
                                  : 'Creado el: ${widget.item.date}',
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: rojoIntenso),
                              textAlign: TextAlign.left,
                            ),
                            Container(
                                child: widget.item.editdate == null
                                    ? Container()
                                    : Text(
                                        _seeLanguage()
                                            ? 'Last edition at: ${widget.item.editdate}'
                                            : 'Última edición el: ${widget.item.editdate}',
                                        style: const TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: rojoIntenso),
                                      )),
                          ],
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
                              fontSize: 20, fontWeight: FontWeight.w300),
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
                        initialValue: widget.item.todoTitle,
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
                                ? 'Enter a new title'
                                : 'Ingresa un nuevo título',
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
                              fontSize: 20, fontWeight: FontWeight.w300),
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
                        initialValue: widget.item.todoText,
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
                            hintText: _seeLanguage()
                                ? 'Enter a new description'
                                : 'Ingresa una nueva descripción',
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
                            ? 'Choose a new category'
                            : 'Escoge una nueva categoría',
                        style: TextStyle(
                          fontSize: 16.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          _changeLanguage(),
                          style: const TextStyle(
                              color: rojoIntenso,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.5),
                        )),
                    CategoryPicker(
                      listCat: widget.category,
                      onChanged: (String? newCategory) {
                        setState(() => selectedCat = newCategory.toString());
                      },
                      category: widget.item.category.toString(),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 20.0, left: 30.0),
                      child: Text(
                        _seeLanguage()
                            ? 'Choose a new color'
                            : 'Escoge un nuevo color',
                        style: TextStyle(
                          fontSize: 16.5,
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
                        chosenColor: _color),
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
                      _editToDoItem(_todoControllerTitle.text,
                          _todoControllerContent.text);
                      Navigator.pop(context);
                    },
                  ),
                )),
              ],
            )));
  }

  void _editToDoItem(String toDoTitle, String toDoContent) {
    setState(() {
      //Asignación de la categoría al editarlo
      widget.item.todoTitle = toDoTitle;
      widget.item.todoText = toDoContent;
      widget.item.ncolor = _color;
      widget.item.category = selectedCat;
      widget.item.editdate = editdate;
      widget.item.datef = DateTime.now();
      context.read<Changes>().changeUsedTrue();
    });
  }

  String _changeLanguage() {
    if (context.read<Changes>().language == "ESP") {
      if (widget.item.category == "Shopping") {
        return "Categoría previa: Compras";
      } else if (widget.item.category == "Learn") {
        return "Categoría previa: Estudios";
      } else if (widget.item.category == "Personal") {
        return "Categoría previa: Personal";
      } else if (widget.item.category == "Wishlist") {
        return "Categoría previa: Deseos";
      } else if (widget.item.category == "Work") {
        return "Categoría previa: Trabajo";
      }
    }

    return "Previous category: ${widget.item.category}";
  }

  bool _seeLanguage() {
    if (context.read<Changes>().language == "ESP") {
      return false;
    }
    return true;
  }
}
