import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  List<String> categoryList = [];

  int categoryIndex = 0;

  addCategoryData(String category) {
    categoryList.add(category);
    notifyListeners();
  }

  List<String> getCategoryList() => categoryList;

  String getCategoryByIndex(int index) {
    String category = categoryList[index];
    return category;
  }

  void updateCategory(String category, int index) {
    categoryList[index] = category;
    notifyListeners();
  }

  void removeCategory(int index) {
    categoryList.removeAt(index);
    notifyListeners();
  }
}
