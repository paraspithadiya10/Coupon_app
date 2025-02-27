import 'package:flutter/material.dart';

class CouponProvider extends ChangeNotifier {
  List<Map<String, dynamic>> couponList = [];

  void addCoupon(context, Map<String, dynamic> couponItem) {
    couponList.add(couponItem);
    notifyListeners();
  }

  List<Map<String, dynamic>> getCouponList() => couponList;

  Map<String, dynamic> getCoupon(int index) {
    Map<String, dynamic> coupon = couponList[index];
    return coupon;
  }

  void updateCoupon(Map<String, dynamic> coupon, index) {
    couponList[index] = coupon;
    notifyListeners();
  }

  void removeCoupon(int index) {
    couponList.removeAt(index);
    notifyListeners();
  }
}
