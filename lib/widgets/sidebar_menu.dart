import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/colors.dart';
import 'package:flutter_todo_app/model/category.dart';
import 'package:flutter_todo_app/screens/deleted_todos.dart';
import 'package:flutter_todo_app/screens/Schecks/home_checks.dart';
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
      backgroundColor:
          context.read<Changes>().darkModes ? Colors.white : NegroSuave,
      child: Column(
        children: [
          Column(
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
                child:  Text(
                  "User",
                  style:  TextStyle(
                        color: context.read<Changes>().darkModes ? Colors.black: Colors.white,
                      ),
                ),
              )
            ],
          ),
          Expanded(
              child: ListView(children: [
            Container(
                margin: const EdgeInsets.only(bottom: 25.0, left: 15.0),
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
                                    builder: (context) =>
                                        const DeletedToDos())),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 1),
                            leading: const Icon(
                              Icons.delete,
                              color: rojoIntenso,
                            ),
                            title: Text(
                              context.read<Changes>().tTrashCan,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: rojoIntenso,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckList())),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 1),
                            leading: const Icon(
                              Icons.checklist_outlined,
                              color: Colors.green,
                              //color: rojoIntenso,
                            ),
                            title: Text(
                              context.read<Changes>().tCheckList,
                              style: TextStyle(fontSize: 16, color: Colors.green
                                  //color: rojoIntenso,
                                  //fontWeight: FontWeight.bold
                                  ),
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
                            iconColor: context.read<Changes>().darkModes
                                ? Colors.black
                                : Colors.white,
                            title: Text(
                              context.read<Changes>().tAll,
                              style: TextStyle(
                                fontSize: 16,
                                color: context.read<Changes>().darkModes
                                    ? Colors.black
                                    : Colors.white,
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
                          color: context.read<Changes>().darkModes
                              ? Colors.black
                              : Colors.white,
                          onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FullCategories()),
                                ),
                              }),
                      title: Text(
                        context.read<Changes>().taCategory,
                        style: TextStyle(
                            color: context.read<Changes>().darkModes
                                ? Colors.black
                                : Colors.white,
                            fontSize: 15),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        context.read<Changes>().changeLanguage();
                      },
                      contentPadding: const EdgeInsets.only(left: 2.0),
                      leading: IconButton(
                          icon: const Icon(Icons.language),
                          color: context.read<Changes>().darkModes
                              ? Colors.black
                              : Colors.white,
                          onPressed: () => {}),
                      title: Text(
                        context.read<Changes>().tLanguage,
                        style: TextStyle(
                            color: context.read<Changes>().darkModes
                                ? Colors.black
                                : Colors.white,
                            fontSize: 15),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        context.read<Changes>().changeTheme();
                      },
                      contentPadding: const EdgeInsets.only(left: 2.0),
                      leading: IconButton(
                          icon: const Icon(Icons.sunny),
                          color: context.read<Changes>().darkModes
                              ? Colors.black
                              : Colors.white,
                          onPressed: () => {}),
                      title: Text(
                        context.read<Changes>().tDarkMode,
                        style: TextStyle(
                            color: context.read<Changes>().darkModes
                                ? Colors.black
                                : Colors.white,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ))
          ])),
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
      context.read<Changes>().resetCantidad();
      Navigator.pop(context);
    });
  }
}
