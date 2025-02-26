import 'package:flutter/material.dart';

class CouponProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> couponItems = [
    {
      'discount': 10,
      'brandName': 'Castel Winery',
      'date': 'jun 1 - jun 8',
      'isBelongsTo': true,
    },
    {
      'discount': 15,
      'brandName': 'Pancakes House',
      'date': 'jun 1 - jun 24',
      'isBelongsTo': false,
    },
    {
      'discount': 10,
      'brandName': 'Spa Boutique',
      'date': 'jun 1 - jun 8',
      'isBelongsTo': true,
    },
    {
      'discount': 15,
      'brandName': 'H & M',
      'date': 'jun 1 - jun 8',
      'isBelongsTo': false,
    },
    {
      'discount': 5,
      'brandName': 'Apple online store',
      'date': 'jun 1 - jun 18',
      'isBelongsTo': true,
    },
    {
      'discount': 5,
      'brandName': 'Mashya Restaurant',
      'date': 'jun 1 - jun 8',
      'isBelongsTo': false,
    },
  ];

  List<Map<String, dynamic>> selectedCoupon = [];

  int couponIndex = 0;

  void addCoupon(context) {
    if (couponIndex >= couponItems.length) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('information'),
                content: Text('There is no more coupon to add'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Ok'))
                ],
              ));
      couponIndex = couponItems.length + 1;
    } else {
      selectedCoupon.add(couponItems[couponIndex]);
      couponIndex++;
    }

    notifyListeners();
  }

  List<Map<String, dynamic>> getCoupon() => selectedCoupon;
}
