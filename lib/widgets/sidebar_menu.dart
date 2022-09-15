import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/category.dart';
import 'package:flutter_todo_app/widgets/category_item.dart';
import '../screens/new_category.dart';
import '../global/globals.dart' as globals;

// ignore: camel_case_types
class sidebarMenu extends StatefulWidget {
  const sidebarMenu({
    Key? key,
    required this.listac,
  }) : super(key: key);
  final List<CategoriaTodo> listac;

  @override
  State<sidebarMenu> createState() => _sidebarMenuState();
}

// ignore: camel_case_types
class _sidebarMenuState extends State<sidebarMenu> {
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
                      margin: const EdgeInsets.only(top: 50),
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
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: ListTile(
                      onTap: () {
                        _changeListNotes([
                          'Uncategorized',
                          'Personal',
                          'Work',
                          'Shopping',
                          'Learn',
                          'Whitlist'
                        ]);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 1),
                      leading: const Icon(Icons.all_inbox),
                      title: const Text(
                        "All",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  for (CategoriaTodo todoo in widget.listac)
                    _createCategory(todoo),
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 2.0),
                    leading: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FullCategories(listac: widget.listac)),
                      ),
                    ),
                    title: const Text(
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

  void _deleteToDoItem(CategoriaTodo cat) {
    setState(() {
      cat.isUsed = false;
    });
  }

  void _changeUsedTrue(CategoriaTodo cat) {
    setState(() {
      cat.isUsed = true;
    });
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

  void _changeListNotes(List<String> lista) {
    setState(() {
      globals.CategoriasActivas = lista;
      globals.titulo = 'AllTodos';
      Navigator.pop(context);
    });
  }
}
