import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../model/check.dart';
import '../constants/colors.dart';
import '../screens/Schecks/edit_checks.dart';
import 'package:provider/provider.dart';
import '../providers/provider.dart';

class checkItem extends StatefulWidget {
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
  State<checkItem> createState() => _checkItemState();
}

class _checkItemState extends State<checkItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditCheck(item: widget.todo)));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: widget.todo.ncolor,
        leading: IconButton(
          icon: Icon(widget.todo.isDone
              ? Icons.check_box
              : Icons.check_box_outline_blank),
          color:
              context.read<Changes>().darkModes ? Colors.black : Colors.white,
          onPressed: () {
            //Cambio de estado del CHECK
            widget.todo.isDone
                ? widget.todo.isDone = false
                : widget.todo.isDone = true;
            context.read<Changes>().editCheck(widget.todo);
            //A continuacion *redoble de tambores*, el sonido xd
            AudioPlayer().play(AssetSource('click.mp3'));
          },
        ),
        title: Text(
          widget.todo.todoTitle!,
          style: TextStyle(
            fontSize: 16,
            color: context.read<Changes>().darkModes ? tdBlack : Colors.white,
            decoration: widget.todo.isDone ? TextDecoration.lineThrough : null,
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
            onPressed: () => widget.onDeleteItem(widget.todo),
          ),
        ),
      ),
    );
  }
}
