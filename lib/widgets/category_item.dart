import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/category.dart';
import '../global/globals.dart' as globals;
import '../providers/provider.dart';

class CategoryItem extends StatefulWidget {
  final CategoriaTodo categoria;
  // ignore: prefer_typing_uninitialized_variables
  final deleteCategory;
  // ignore: prefer_typing_uninitialized_variables
  final changeUsed;

  const CategoryItem(
      {Key? key,
      required this.categoria,
      required this.changeUsed,
      required this.deleteCategory})
      : super(key: key);

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: ListTile(
        onTap: () {
          if (widget.categoria.isUsed) {
            _changeListNotes();
            context.read<Changes>().setTitle(widget.categoria.catText!);
          } else {
            widget.changeUsed(widget.categoria);
            Navigator.pop(context);
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        leading: widget.categoria.iconDesign,
        title: Text(
          widget.categoria.catText!,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          child: widget.categoria.isUsed
              ? IconButton(
                  color: Colors.black,
                  iconSize: 18,
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    widget.deleteCategory(widget.categoria);
                  },
                )
              : Container(),
        ),
      ),
    );
  }

  void _changeListNotes() {
    //Actualización de las notas y la categoría
    setState(() {
      List<String> lista = [];
      globals.CategoriasActivas = lista;
      globals.titulo =
          widget.categoria.catText!; //Texto de la categoría seleccionada
      Navigator.pop(context);
    });
  }
}
