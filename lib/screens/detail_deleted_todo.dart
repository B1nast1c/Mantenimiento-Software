// ignore_for_file: non_constant_identifier_names
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/deleted_todo.dart';
import '../constants/colors.dart';
import 'package:provider/provider.dart';

import '../providers/provider.dart';
//========================================//
//                                        //
//   PANTALLA VISUALIZACIÓN ELIMINADAS    //
//                                        //
//========================================//

//BUGS:
//
class DetailDeletedTodo extends StatefulWidget {
  const DetailDeletedTodo(
      {Key? key, required this.item, required this.restore_item})
      : super(key: key);
  final DeletedToDo item;
  final void Function(DeletedToDo) restore_item;

  @override
  State<DetailDeletedTodo> createState() => _DetailDeletedTodsState();
}

class _DetailDeletedTodsState extends State<DetailDeletedTodo> {
  @override
  Widget build(BuildContext context) {
    String? title = widget.item.todoTitle,
        details = widget.item.todoText,
        category = widget.item.category;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: weso,
        appBar: AppBar(
          backgroundColor: context.read<Changes>().darkModes ? Colors.white: Colors.black,
          foregroundColor: context.read<Changes>().darkModes ?  Colors.black: Colors.white,
          elevation: 0,
        ),
        body: Container(
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(250),
              bottomLeft: Radius.circular(250),
            ),
            color: context.read<Changes>().darkModes ? Colors.white: Colors.black,
          ),
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 40.0, horizontal: 50.0),
                    child: Text(
                      _seeLanguage() ? "Todo Details" : 'Detalles nota',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                        color: context.read<Changes>().darkModes ? Colors.black: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 30, bottom: 10, top: 20),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: _seeLanguage()
                          ? Text(
                              "Title",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold, 
                                  color: context.read<Changes>().darkModes ? Colors.black: Colors.white),
                            )
                          : Text(
                              "Título",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold,
                                  color: context.read<Changes>().darkModes ? Colors.black: Colors.white),
                            ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 30, bottom: 10),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "$title",
                        style:  TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300,
                            color: context.read<Changes>().darkModes ? Colors.black: Colors.white,),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 30, bottom: 10, top: 25),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        _seeLanguage() ? "Details" : 'Detalles',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold,
                            color: context.read<Changes>().darkModes ? Colors.black: Colors.white,),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 30, bottom: 10),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "$details",
                        style:  TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300, 
                            color: context.read<Changes>().darkModes ? Colors.black: Colors.white,),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 30, bottom: 10, top: 25),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        _seeLanguage() ? "Category" : 'Categoría',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold,
                            color: context.read<Changes>().darkModes ? Colors.black: Colors.white,),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 30, bottom: 10),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "$category",
                        style:  TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300,
                            color: context.read<Changes>().darkModes ? Colors.black: Colors.white,),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 60),
                    child: Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      const EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 40.0)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(weso),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0),
                              ))),
                          onPressed: () {
                            widget.restore_item(widget.item);
                            Navigator.pop(context);
                          },
                          child: Text(
                            _seeLanguage() ? "Recover ToDo" : 'Eliminar nota',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  bool _seeLanguage() {
    if (context.read<Changes>().language == "ESP") {
      return false;
    }
    return true;
  }
}
