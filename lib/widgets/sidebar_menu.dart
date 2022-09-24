import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/colors.dart';
import 'package:flutter_todo_app/model/category.dart';
import 'package:flutter_todo_app/screens/deleted_todos.dart';
import 'package:flutter_todo_app/widgets/category_item.dart';
import 'package:provider/provider.dart';
import '../providers/provider.dart';
import '../screens/new_category.dart';
import '../global/globals.dart' as globals;

//========================================//
//                                        //
//       WIDGET DE MENÚ DEL COSTADO       //
//                                        //
//========================================//

//USO EN:
//  home
//
//BUGS:
//

// ignore: camel_case_types
class sidebarMenu extends StatefulWidget {
  const sidebarMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<sidebarMenu> createState() => _sidebarMenuState();
}

// ignore: camel_case_types
class _sidebarMenuState extends State<sidebarMenu> {
  @override
  Widget build(BuildContext context) {
    var categoriesList = context.watch<Changes>().listCategories;

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
                        "User",
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
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DeletedToDos())),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 1),
                          leading: const Icon(
                            Icons.delete,
                            color: rojoIntenso,
                          ),
                          title: const Text(
                            "TrashCan",
                            style: TextStyle(
                                fontSize: 16,
                                color: rojoIntenso,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            _changeListNotes([
                              'Deleted',
                              'Uncategorized',
                              'Personal',
                              'Work',
                              'Shopping',
                              'Learn',
                              'Wishlist'
                            ]);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 1),
                          leading: const Icon(Icons.toc),
                          title: const Text(
                            "All",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  for (CategoriaTodo category in categoriesList)
                    _createCategory(
                        category), //Crea las categorias que tienen el atributo usado en TRUE
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 2.0),
                    leading: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FullCategories()),
                              ),
                            }),
                    title: const Text(
                      "Add Category",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  void _deleteCategory(CategoriaTodo cat) {
    setState(() {
      cat.isUsed = false;
    });
  }

  void _changeUsedTrue(CategoriaTodo cat) {
    setState(() {
      cat.isUsed = true;
    });
  }

  Widget _createCategory(CategoriaTodo category) {
    //Renderiza las categorias usadas
    if (category.isUsed) {
      return CategoryItem(
        categoria: category,
        deleteCategory: _deleteCategory,
        changeUsed: _changeUsedTrue,
      );
    }
    return Container();
  }

  void _changeListNotes(List<String> lista) {
    setState(() {
      globals.CategoriasActivas = lista;
      context.read<Changes>().setTitle('All Todos');
      Navigator.pop(context);
    });
  }
}
