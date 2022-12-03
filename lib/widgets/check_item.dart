import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../model/check.dart';
import '../constants/colors.dart';
import '../screens/Schecks/edit_checks.dart';
import 'package:provider/provider.dart';
import '../providers/provider.dart';

class checkItem extends StatelessWidget {
  final Check todo;
  // ignore: prefer_typing_uninitialized_variables
  final onToDoChanged;
  // ignore: prefer_typing_uninitialized_variables
  final onDeleteItem;
  //final List<CategoriaTodo> category;

  const checkItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
    //required this.category
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditCheck(item: todo)));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: todo.ncolor,
        leading: IconButton(
          icon: Icon(
              todo.isDone ? Icons.check_box : Icons.check_box_outline_blank),
          color: Colors.black,
          onPressed: () {
            //Cambio de estado del CHECK
            todo.isDone ? todo.isDone = false : todo.isDone = true;
            context.read<Changes>().editCheck(todo);
            //A continuacion *redoble de tambores*, el sonido xd
            AudioPlayer().play(AssetSource('click.mp3'));
          },
        ),
        title: Text(
          todo.todoTitle!,
          style: TextStyle(
            fontSize: 16,
            color: tdBlack,
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
