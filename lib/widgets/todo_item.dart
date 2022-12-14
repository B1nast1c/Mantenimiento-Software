import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/category.dart';
import '../model/todo.dart';
import '../constants/colors.dart';
import '../screens/edit_todo.dart';
import 'package:provider/provider.dart';
import '../providers/provider.dart';

//========================================//
//                                        //
//             WIDGET DE NOTA             //
//                                        //
//========================================//

//USO EN:
//  home
//
//BUGS:
//

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  // ignore: prefer_typing_uninitialized_variables
  final onToDoChanged;
  // ignore: prefer_typing_uninitialized_variables
  final onDeleteItem;
  final List<CategoriaTodo> category;

  const ToDoItem(
      {Key? key,
      required this.todo,
      required this.onToDoChanged,
      required this.onDeleteItem,
      required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var styleIdx = context.watch<Changes>().noteStyle - 1;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      EditTodo(item: todo, category: category)));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: todo.ncolor,
        title: Text(
          todo.todoTitle!,
          style: TextStyle(
            fontWeight: styleIdx == 1
                ? FontWeight.bold
                : FontWeight.normal, //Cambio a la opción 1
            fontStyle: styleIdx == 2
                ? FontStyle.italic
                : FontStyle.normal, //Cambio a la opción 2
            fontSize: styleIdx == 3
                ? 20
                : styleIdx == 4
                    ? 13
                    : 16,
            color: context.read<Changes>().darkModes ? tdBlack: NegroSuave,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
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
            onPressed: () => onDeleteItem(todo),
          ),
        ),
      ),
    );
  }
}
