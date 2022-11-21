import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/category.dart';
import 'package:flutter_todo_app/widgets/category_item.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../providers/provider.dart';

//========================================//
//                                        //
//      PANTALLA AÑADIR CATEGORIAS        //
//                                        //
//========================================//

//BUGS:
//
class FullCategories extends StatefulWidget {
  const FullCategories({Key? key}) : super(key: key);

  @override
  State<FullCategories> createState() => _FullCategoriesState();
}

class _FullCategoriesState extends State<FullCategories> {
  @override
  Widget build(BuildContext context) {
    final categoryList = context.watch<Changes>().listCategories;

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
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 40.0, horizontal: 10.0),
                      child: _seeLanguage()
                          ? Text(
                              'Unused categories',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          : Text(
                              'Categorias sin usar',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(bottom: 35.0, left: 35.0),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            for (CategoriaTodo category in categoryList)
                              _createCategory(category,
                                  categoryList), //Genera aquellas categorias que no estan dentro del menú lateral
                          ],
                        )),
                  ],
                ),
              ],
            )));
  }

  void _deleteCategory(CategoriaTodo cat) {
    //Manda la categoria usada a no usada
    setState(() {
      cat.isUsed = false;
    });
  }

  void _changeUsedTrue(CategoriaTodo cat) {
    //Una vez que seleccionamos la categoria vamos al home para actualizar las categori
    cat.isUsed = true;
  }

  Widget _createCategory(CategoriaTodo cat, List<CategoriaTodo> list) {
    //Renderiza las categorias no usadas
    if (cat.isUsed == false) {
      return CategoryItem(
        categoria: cat,
        deleteCategory: _deleteCategory,
        changeUsed: _changeUsedTrue,
      );
    }
    return Container();
  }

  bool _seeLanguage() {
    if (context.read<Changes>().language == "ESP") {
      return false;
    }
    return true;
  }
}
