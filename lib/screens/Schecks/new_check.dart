import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/../model/check.dart';
import '/../constants/colors.dart';
import '/../providers/provider.dart';
import '/../widgets/color_picker.dart';
import 'package:intl/intl.dart';

String date = DateFormat.yMMMEd().format(DateTime.now());

class NewCheck extends StatefulWidget {
  const NewCheck({Key? key}) : super(key: key);

  @override
  State<NewCheck> createState() => _NewCheckState();
}

class _NewCheckState extends State<NewCheck> {
  Color _color = Colors.white;
  final _todoControllerTitle = TextEditingController();
  final _todoControllerContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    var CheckList = context.watch<Changes>().listCheck;
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
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 40.0, horizontal: 10.0),
                      child: Text(
                        'Add new Check',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 30, bottom: 10),
                      child: const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Title',
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
                            hintText: 'Enter the title',
                            hintStyle: const TextStyle(
                              color: tdGrey,
                            ),
                            fillColor: tdBGColor),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 20.0, left: 30.0),
                      child: const Text(
                        'Choose a color for your ToDo',
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
                          _todoControllerContent.text, CheckList);
                      Navigator.pop(context);
                    },
                  ),
                )),
              ],
            )));
  }

  void _addToDoItem(String toDoTitle, String toDoContent, List<Check> list) {
    Check nota = Check(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoTitle: toDoTitle,
        ncolor: _color,
        date: date,
        datef: DateTime.now());
    //nota.date = date;
    list.add(nota);
    context.read<Changes>().setListCheck(list);

    _todoControllerTitle.clear();
    _todoControllerContent.clear();
  }
}
