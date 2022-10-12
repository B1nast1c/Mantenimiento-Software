import 'package:flutter/material.dart';
import 'package:flutter_todo_app/screens/detail_deleted_todo.dart';
import '../model/deleted_todo.dart';
import '../constants/colors.dart';

//========================================//
//                                        //
//        WIDGET DE NOTA ELIMINADA        //
//                                        //
//========================================//

//USO EN:
//  deleted_todos
//
//BUGS:
//

class DeletedToDoItem extends StatelessWidget {
  final DeletedToDo todo;
  // ignore: prefer_typing_uninitialized_variables
  final removeToDo;
  // ignore: prefer_typing_uninitialized_variables
  final restoreToDo;

  const DeletedToDoItem({
    Key? key,
    required this.todo,
    required this.removeToDo,
    required this.restoreToDo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => todo.startTimer());
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: rojoIntenso, width: 1.5),
      ),
      margin: const EdgeInsets.only(bottom: 20, left: 20.0, right: 20.0),
      //Al darle click debe mostrarse la pantalla de visualización de detalle
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailDeletedTodo(
                      item: todo,
                      restore_item: (DeletedToDo item) => restoreToDo(item),
                    )),
          );
          //restoreToDo(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: todo.ncolor,
        leading: const Icon(
          Icons.close,
          color: Colors.black,
        ),
        title: Text(
          todo.todoTitle!,
          style: const TextStyle(
            fontSize: 16,
            color: tdBlack,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
            onPressed: () {
              //Eliminación permanente
              removeToDo(todo);
            },
          ),
        ),
      ),
    );
  }
}
