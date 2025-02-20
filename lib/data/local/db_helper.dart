import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  /// Singleton
  DbHelper();
  static final DbHelper getInstance = DbHelper();

  static final String userTable = 'users';
  static final String userId = 'id';
  static final String userName = 'username';
  static final String userEmail = 'email';
  static final String userPassword = 'password';

  Database? myDB;

  /// db Open(path -> if exist -> open, if not exist -> create)
  Future<Database> getDB() async {
    myDB ??= await openDB();
    return myDB!;

    // if (myDB != null) {
    //   return myDB!;
    // } else {
    //   myDB = await OpenDB();
    //   return myDB!;
    // }
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String path = join(appDir.path, 'couponDB.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            'create table $userTable ($userId INTEGER PRIMARY KEY AUTOINCREMENT, $userName TEXT, $userEmail TEXT, $userPassword TEXT)');
      },
    );
  }

  // insert user into users table
  Future<bool> addUser(
      {required String username,
      required String email,
      required String password}) async {
    var db = await getDB();

    int rowsEffected = await db.insert(userTable, {
      userName: username,
      userEmail: email,
      userPassword: password,
    });

    return rowsEffected > 0;
  }

  // fetch all user from users table
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    var db = await getDB();
    List<Map<String, dynamic>> userData = await db.query(userTable);
    return userData;
  }

  // fetch specific user from users email and password
  Future<List<Map<String, dynamic>>> getUser(
      String email, String password) async {
    var db = await getDB();
    List<Map<String, dynamic>> userData = await db.query(userTable,
        where: '$userEmail = ? AND $userPassword = ?',
        whereArgs: [email, password]);

    return userData;
  }

  // delete user from users table
  Future<bool> deleteUser(String email) async {
    var db = await getDB();
    int rowsEffected =
        await db.delete(userTable, where: '$userEmail = ?', whereArgs: [email]);

    return rowsEffected > 0;
  }
}
