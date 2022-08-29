import 'package:flutter/material.dart';
import '../constants/colors.dart';

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
                      margin: EdgeInsets.only(top: 100),
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
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Usuario",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                )),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 35.0, left: 15.0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  const ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      "Personal",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text(
                      "Wishlist",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.book),
                    title: Text(
                      "Learn",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.work),
                    title: Text(
                      "Work",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 2.0),
                    leading: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => print('Nueva Categoria'),
                    ),
                    title: Text(
                      "Añadir categoría",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              )),
          Container(
              child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              color: rojoIntenso,
              padding: const EdgeInsets.fromLTRB(10, 50, 50, 50),
            ),
          ))
        ],
      ),
    );
  }
}
