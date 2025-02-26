import 'package:flutter/cupertino.dart';

class CategoryProvider extends ChangeNotifier {
  List<String> categoryItems = <String>[
    'Grocery',
    'Clothing',
    'Health & Beauty',
    'Sports',
    'Furniture',
    'Electronics',
  ];

  List<String> selectedCategories = [];

  int categoryIndex = 0;

  addCategoryData() {
    selectedCategories.add(categoryItems[categoryIndex]);
    categoryIndex++;
    if (categoryIndex == categoryItems.length) {
      categoryIndex = 0;
    }
    notifyListeners();
  }

  List<String> getSelectedCategoryData() => selectedCategories;
}
