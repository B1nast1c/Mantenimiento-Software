import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/category.dart';
import 'package:flutter_todo_app/widgets/category_item.dart';
import '../constants/colors.dart';
import '../screens/new_category.dart';

// ignore: camel_case_types
class sidebarMenu extends StatelessWidget {
  const sidebarMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: DrawerHeader(
                decoration: BoxDecoration(
                  border: Border(
                    bottom:
                        Divider.createBorderSide(context, color: Colors.white),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      height: 135,
                      width: 135,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image.asset(
                          "assets/images/avatar.jpeg",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: const Text(
                        "Usuario",
                      ),
                    )
                  ],
                )),
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 35.0, left: 15.0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  for (CategoriaTodo todoo in CategoriaTodo.fullCategory())
                    _createCategory(todoo),
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 2.0),
                    leading: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FullCategories()),
                      ),
                    ),
                    title: Text(
                      "Añadir categoría",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              )),
          /*  Container(
              child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              color: rojoIntenso,
              padding: const EdgeInsets.fromLTRB(10, 50, 50, 50),
            ),
          ))*/
        ],
      ),
    );
  }
}

void _deleteToDoItem(CategoriaTodo cat) {
  cat.isUsed = false;
}

void _changeUsedTrue(CategoriaTodo cat) {
  cat.isUsed = true;
}

Widget _createCategory(CategoriaTodo todoo) {
  if (todoo.isUsed) {
    return CategoryItem(
      categoria: todoo,
      deleteCategory: _deleteToDoItem,
      chageUsed: _changeUsedTrue,
    );
  }
  return Container();
}
