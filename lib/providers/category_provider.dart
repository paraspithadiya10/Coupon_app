import 'package:flutter/material.dart';

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

  addCategoryData(context) {
    if (categoryIndex >= categoryItems.length) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('information'),
                content: Text('There is no more category to add'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Ok'))
                ],
              ));
      categoryIndex = categoryItems.length + 1;
    } else {
      selectedCategories.add(categoryItems[categoryIndex]);
      categoryIndex++;
    }
    notifyListeners();
  }

  List<String> getSelectedCategoryData() => selectedCategories;
}
