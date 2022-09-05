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
    return [];
  }

  static List<CategoriaTodo> fullCategory() {
    return [
      CategoriaTodo(
          id: '01', catText: 'Personal', iconDesign: const Icon(Icons.person)),
      CategoriaTodo(
          id: '02',
          catText: 'Whitlist',
          iconDesign: const Icon(Icons.favorite)),
      CategoriaTodo(
          id: '04', catText: 'Work', iconDesign: const Icon(Icons.work)),
      CategoriaTodo(
          id: '05',
          catText: 'Shopping',
          isUsed: true,
          iconDesign: const Icon(Icons.shop)),
      CategoriaTodo(
          id: '03',
          catText: 'Learn',
          isUsed: true,
          iconDesign: const Icon(Icons.book)),
    ];
  }
}
