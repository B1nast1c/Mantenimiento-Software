import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/category.dart';

class CategoryItem extends StatelessWidget {
  final CategoriaTodo categoria;
  final deleteCategory;
  final chageUsed;

  const CategoryItem(
      {Key? key,
      required this.categoria,
      required this.chageUsed,
      required this.deleteCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: ListTile(
        onTap: () {
          chageUsed(categoria);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        leading: categoria.iconDesign,
        title: Text(
          categoria.catText!,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          child: IconButton(
            color: Colors.black,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {
              // print('Clicked on delete icon');
              deleteCategory(categoria);
            },
          ),
        ),
      ),
    );
  }
}
