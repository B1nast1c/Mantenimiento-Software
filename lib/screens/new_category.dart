import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/category.dart';
import 'package:flutter_todo_app/widgets/category_item.dart';
import '../constants/colors.dart';

class FullCategories extends StatefulWidget {
  const FullCategories({Key? key, required this.listac}) : super(key: key);
  final List<CategoriaTodo> listac;

  @override
  State<FullCategories> createState() => _FullCategoriesState();
}

class _FullCategoriesState extends State<FullCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: rojoIntenso,
        appBar: AppBar(
          backgroundColor: rojoIntenso,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
                topRight: Radius.circular(60),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 40.0, horizontal: 10.0),
                      child: Text(
                        'Lista gategorias',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 30, bottom: 10),
                      child: const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Categorías',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(bottom: 35.0, left: 15.0),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            for (CategoriaTodo todoo in widget.listac)
                              _createCategory(todoo),
                          ],
                        )),
                  ],
                ),
              ],
            )));
    ;
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
    if (todoo.isUsed == false) {
      return CategoryItem(
        categoria: todoo,
        deleteCategory: _deleteToDoItem,
        chageUsed: _changeUsedTrue,
      );
    }
    return Container();
  }
}
