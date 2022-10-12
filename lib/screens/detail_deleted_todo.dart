// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/deleted_todo.dart';
import 'package:flutter_todo_app/widgets/deleted_todo_item.dart';
import '../constants/colors.dart';

//========================================//
//                                        //
//   PANTALLA VISUALIZACIÓN ELIMINADAS    //
//                                        //
//========================================//

//BUGS:
//
class DetailDeletedTodo extends StatelessWidget {
  const DetailDeletedTodo(
      {Key? key, required this.item, required this.restore_item})
      : super(key: key);
  final DeletedToDo item;
  final void Function(DeletedToDo) restore_item;

  @override
  Widget build(BuildContext context) {
    String? title = item.todoTitle,
        details = item.todoText,
        category = item.category;
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
              bottomRight: Radius.circular(250),
              bottomLeft: Radius.circular(250),
            ),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Column(
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 40.0, horizontal: 50.0),
                    child: Text(
                      "Todo Details",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 30, bottom: 10, top: 20),
                    child: const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Title",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 30, bottom: 10),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "$title",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 30, bottom: 10, top: 25),
                    child: const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Details",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 30, bottom: 10),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "$details",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 30, bottom: 10, top: 25),
                    child: const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Category",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 30, bottom: 10),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "$category",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
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
                            restore_item(item);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Recover ToDo",
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
}
