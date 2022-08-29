import 'package:flutter/material.dart';

class CategoriaTodo {
  String? id;
  String? catText;
  bool isUsed;
  //String? color; //Color de la nota Este no funciona
  Icon? iconDesign; // Este si

  CategoriaTodo({
    required this.id,
    required this.catText,
    this.isUsed = false,
    this.iconDesign = const Icon(Icons.cabin),
  });


  static List<CategoriaTodo> categoryList() {
    return [
    ];
  }

  static List<CategoriaTodo> fullCategory() {
    return [
      CategoriaTodo(id: '01', catText: 'Personal' , iconDesign: const Icon(Icons.person) ),
      CategoriaTodo(id: '02', catText: 'Whitlist', iconDesign: const Icon(Icons.favorite) ),

    ];
  }
}