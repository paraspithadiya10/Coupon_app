// country_db_helper.dart
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class CountryDbHelper {
  /// Singleton
  CountryDbHelper._();
  static final CountryDbHelper getInstance = CountryDbHelper._();

  Database? myDB;

  // Table and column names.
  static final String tableName = 'countries';
  static final String colCode = 'code';
  static final String colName = 'name';
  static final String colFlagUrl = 'flagUrl';
  static final String colCurrency = 'currency';

  /// Returns the database instance; if null, opens/creates the database.
  Future<Database> getDB() async {
    myDB ??= await openDB();
    return myDB!;
  }

  /// Opens the database (if it doesn't exist, creates it).
  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String path = join(appDir.path, 'countries.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $tableName ($colCode TEXT PRIMARY KEY, $colName TEXT, $colFlagUrl TEXT, $colCurrency TEXT)',
        );
      },
    );
  }

  /// Inserts multiple countries using a batch operation.
  Future<void> insertCountries(List<Map<String, dynamic>> countries) async {
    var db = await getDB();
    var batch = db.batch();
    for (var country in countries) {
      batch.insert(
        tableName,
        country,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  /// Fetches all countries from the database.
  Future<List<Map<String, dynamic>>> getAllCountries() async {
    var db = await getDB();
    return await db.query(tableName);
  }

  /// Deletes a country from the database by its code.
  Future<bool> deleteCountry(String code) async {
    var db = await getDB();
    int rowsAffected = await db.delete(
      tableName,
      where: '$colCode = ?',
      whereArgs: [code],
    );
    return rowsAffected > 0;
  }
}




