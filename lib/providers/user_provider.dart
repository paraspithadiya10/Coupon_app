import 'package:demo_app/data/local/db_helper.dart';
import 'package:demo_app/data/preferences/pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  DbHelper dbHelper;
  UserProvider({required this.dbHelper});

  List<Map<String, dynamic>> _userData = [];

  addUser(String username, String email, String password) async {
    bool rowsEffected = await dbHelper.addUser(
        username: username, email: email, password: password);
    if (rowsEffected) {
      _userData = await dbHelper.getAllUsers();
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> getAllUsers() => _userData;

  Future<List<Map<String, dynamic>>> getUser(String email, String password) {
    Future<List<Map<String, dynamic>>> user = dbHelper.getUser(email, password);

    return user;
  }

  Future<List<Map<String, Object?>>> getUserByStoredId() async {
    var sharedPref = await SharedPreferences.getInstance();
    final id = sharedPref.getInt(keyUserId);
    Future<List<Map<String, Object?>>> currentUser =
        dbHelper.getUserByStoredId(id.toString());

    return currentUser;
  }
}
