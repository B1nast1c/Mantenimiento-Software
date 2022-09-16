import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/colors.dart';
import 'package:flutter_todo_app/model/category.dart';

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
          hint: const Center(
              child: Text(
            "Selecciona la categoria",
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
                        e.catText.toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ))
              .toList(),
          selectedItemBuilder: (BuildContext context) => widget.listCat
              .map((e) => Center(
                    child: Text(
                      e.catText.toString(),
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
}
