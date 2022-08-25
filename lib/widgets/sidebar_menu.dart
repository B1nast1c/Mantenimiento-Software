import 'package:flutter/material.dart';

class sidebarMenu extends StatelessWidget {
  const sidebarMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 15),
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset("assets/images/avatar.jpeg"),
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
        ListTile(
          leading: Icon(Icons.person),
          title: Text(
            "Personal",
            style: TextStyle(color: Colors.black),
          ),
        ),
        ListTile(
          leading: Icon(Icons.favorite),
          title: Text(
            "Whitlist",
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
          leading: Icon(Icons.add),
          title: Text(
            "Añadir categoría",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    ));
  }
}
