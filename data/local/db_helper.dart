import 'package:sqflite/sqlite_api.dart';

class DbHelper {
  /// Singleton
  DbHelper._();
  static final DbHelper getInstance = DbHelper._();

  Database? myDB;

  /// db Open(path -> if exist -> open, if not exist -> create)
  Database getDB() {
    if (myDB != null) {
      return myDB!;
    } else {
      OpenDB();
      return myDB!;
    }
  }

  OpenDB() {}

  /// all queries
}
