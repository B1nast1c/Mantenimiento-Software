import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/category.dart';
import '../global/globals.dart' as globals;
import '../providers/provider.dart';

//========================================//
//                                        //
//          WIDGET DE CATEGORIA           //
//                                        //
//========================================//

//USO EN:
//  new_category
//  sidebar_menu
//
//BUGS:
//

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
            setState(() {
              widget.changeUsed(widget.categoria);
            });
            context.read<Changes>().changeUsedTrue();
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        leading: widget.categoria.iconDesign,
        iconColor:
            context.read<Changes>().darkModes ? Colors.black : Colors.white,
        title: Text(
          _seeLanguage(),
          style: TextStyle(
            fontSize: 16,
            color: context.read<Changes>().darkModes
                ? Colors.black
                : Colors.white,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          child: widget.categoria.isUsed
              ? IconButton(
                  color: context.read<Changes>().darkModes
                      ? Colors.black
                      : Colors.white,
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
      List<String> lista = [widget.categoria.catText!];
      globals.CategoriasActivas = lista;
      globals.titulo =
          widget.categoria.catText!; //Texto de la categoría seleccionada
      Navigator.pop(context);
    });
  }

  String _seeLanguage() {
    if (context.read<Changes>().language == "ESP") {
      if (widget.categoria.catText! == "Shopping") {
        return "Compras";
      } else if (widget.categoria.catText! == "Learn") {
        return "Estudios";
      } else if (widget.categoria.catText! == "Personal") {
        return "Personal";
      } else if (widget.categoria.catText! == "Wishlist") {
        return "Deseos";
      } else if (widget.categoria.catText! == "Work") {
        return "Trabajo";
      }
    }

    return widget.categoria.catText!;
  }
}
