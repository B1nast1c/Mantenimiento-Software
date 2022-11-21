import 'package:flutter/material.dart';
import 'package:flutter_todo_app/screens/detail_deleted_todo.dart';
import '../model/deleted_todo.dart';
import '../constants/colors.dart';
import 'package:provider/provider.dart';
import '../providers/provider.dart';
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

class DeletedToDoItem extends StatefulWidget {
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
  State<DeletedToDoItem> createState() => _DeletedToDoItemState();
}

class _DeletedToDoItemState extends State<DeletedToDoItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: rojoIntenso, width: 1.5),
      ),
      margin: const EdgeInsets.only(bottom: 20, left: 20.0, right: 20.0),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailDeletedTodo(
                      item: widget.todo,
                      restore_item: (DeletedToDo item) =>
                          widget.restoreToDo(item),
                    )),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: widget.todo.ncolor,
        leading:  Icon(
          Icons.close,
          color: context.read<Changes>().darkModes ? Colors.black: Colors.white,
        ),
        title: Text(
          widget.todo.todoTitle!,
          style:  TextStyle(
            fontSize: 16,
            color: context.read<Changes>().darkModes ? tdBlack: Colors.white ,
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
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text(_seeLanguage() ? 'Attention' : 'Atención'),
                content: Text(_seeLanguage()
                    ? 'Are you sure you want to delete this ToDo?'
                    : '¿Estás seguro que quieres borrar esta nota?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(
                        context, _seeLanguage() ? 'Cancel' : 'Cancelar'),
                    child: Text(_seeLanguage() ? 'Nope' : 'No'),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.removeToDo(widget.todo);
                      Navigator.pop(context);
                    },
                    child: Text(_seeLanguage() ? 'Yep' : 'Sí'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _seeLanguage() {
    if (context.read<Changes>().language == "ESP") {
      return false;
    }
    return true;
  }
}
