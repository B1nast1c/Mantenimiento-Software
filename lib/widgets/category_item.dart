import 'package:flutter/material.dart';

import '../model/category.dart';
import '../global/globals.dart' as globals;

class CategoryItem extends StatefulWidget {
  final CategoriaTodo categoria;
  final deleteCategory;
  final chageUsed;
  CategoryItem(
      {Key? key,
      required this.categoria,
      required this.chageUsed,
      required this.deleteCategory})
      : super(key: key);

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: ListTile(
        onTap: () {
          widget.categoria.isUsed
              ? _changeListNotes(widget.categoria.catText!)
              : widget.chageUsed(widget.categoria);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        leading: widget.categoria.iconDesign,
        title: Text(
          widget.categoria.catText!,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          child: widget.categoria.isUsed
              ? IconButton(
                  color: Colors.black,
                  iconSize: 18,
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // print('Clicked on delete icon');
                    widget.deleteCategory(widget.categoria);
                  },
                )
              : Container(),
        ),
      ),
    );
  }

  void _changeListNotes(String NCategoria) {
    setState(() {
      // print('funcionaa');
      List<String> Lista = [];
      Lista.add(NCategoria);
      globals.CategoriasActivas = Lista;
      // print('funciona');
    });
  }
}
