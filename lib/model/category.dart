import 'package:flutter/material.dart';

class CategoriaTodo {
  String? id;
  String? catText;
  bool isUsed;
  Icon? iconDesign;

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
          catText: 'Wishlist',
          iconDesign: const Icon(Icons.favorite)),
      CategoriaTodo(
          id: '04', catText: 'Work', iconDesign: const Icon(Icons.work)),
      CategoriaTodo(
          id: '05',
          catText: 'Shopping',
          isUsed: true,
          iconDesign: const Icon(Icons.shopping_cart)),
      CategoriaTodo(
          id: '03',
          catText: 'Learn',
          isUsed: true,
          iconDesign: const Icon(Icons.book)),
    ];
  }
}
