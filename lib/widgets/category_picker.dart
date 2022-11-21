import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/colors.dart';
import 'package:flutter_todo_app/model/category.dart';
import 'package:provider/provider.dart';
import '../providers/provider.dart';
//========================================//
//                                        //
//    WIDGET DE SELECCION DE CATEGORIA    //
//                                        //
//========================================//

//USO EN:
//  edit_todo
//  new_todo
//
//BUGS:
//

class CategoryPicker extends StatefulWidget {
  const CategoryPicker(
      {Key? key,
      required this.listCat,
      required this.category,
      required this.onChanged})
      : super(key: key);
  final List<CategoriaTodo> listCat;
  final void Function(String?) onChanged;
  final String? category;

  @override
  State<CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  String? selectedCat;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: rojoIntenso,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: DropdownButton(
          value: selectedCat,
          onChanged: (value) {
            widget.onChanged(value.toString());
            setState(() {
              selectedCat = value.toString();
            });
          },
          hint: Center(
              child: Text(
            _seeLanguage() ? "Select a category  " : 'Selecciona una categoría',
            style: TextStyle(color: rojoIntenso),
          )),
          underline: Container(),
          icon: const Icon(
            Icons.arrow_downward,
            color: rojoIntenso,
          ),
          isExpanded: false,
          items: widget.listCat
              .map((e) => DropdownMenuItem(
                    value: e.catText,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _changeLanguage(e.catText.toString()),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ))
              .toList(),
          selectedItemBuilder: (BuildContext context) => widget.listCat
              .map((e) => Center(
                    child: Text(
                      _changeLanguage(e.catText.toString()),
                      style: const TextStyle(
                          fontSize: 16,
                          color: rojoIntenso,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ))
              .toList(),
        ));
  }

  String _changeLanguage(String catText) {
    if (context.read<Changes>().language == "ESP") {
      if (catText == "Shopping") {
        return "Compras";
      } else if (catText == "Learn") {
        return "Estudios";
      } else if (catText == "Personal") {
        return "Personal";
      } else if (catText == "Wishlist") {
        return "Deseos";
      } else if (catText == "Work") {
        return "Trabajo";
      }
    }

    return catText;
  }

  bool _seeLanguage() {
    if (context.read<Changes>().language == "ESP") {
      return false;
    }
    return true;
  }
}
