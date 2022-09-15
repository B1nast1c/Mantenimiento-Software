import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/category.dart';

class CategoryPicker extends StatefulWidget {
  const CategoryPicker({Key? key, required this.listCat}) : super(key: key);
  final List<CategoriaTodo> listCat;

  @override
  State<CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  int indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(20),
      color: CupertinoColors.white,
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).copyWith().size.height * 0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
            Icons.keyboard_arrow_up,
            color: Colors.black,
            size: 20.0,
          ),
          CupertinoPicker(
            backgroundColor: Colors.white,
            itemExtent: 55,
            onSelectedItemChanged: (index) {
              setState(() {
                indexSelected = index;
              });
            },
            children: widget.listCat
                .map((item) => Center(
                      child: Text(
                        item.catText.toString(),
                        style: const TextStyle(fontSize: 17.5),
                      ),
                    ))
                .toList(),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black,
            size: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoButton(
                onPressed: () {
                  Navigator.pop(context, indexSelected);
                },
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 5.0,
                ),
                child: const Text('Seleccionar categoría'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
