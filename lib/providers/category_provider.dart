import 'dart:math';

import 'package:flutter/cupertino.dart';

class CategoryProvider extends ChangeNotifier {
  List categoryItems = [
    'Grocery',
    'Clothing',
    'Health & Beauty',
    'Sports',
    'Furniture',
    'Electronics',
  ];

  List<String> categoryData = [];

  int categoryIndex = 0;

  addCategoryData() {
    categoryData.add(categoryItems[categoryIndex]);
    categoryIndex++;
    if (categoryIndex == categoryItems.length) {
      categoryIndex = 0;
    }
    notifyListeners();
  }

  List<String> getCategoryData() => categoryData;
}
