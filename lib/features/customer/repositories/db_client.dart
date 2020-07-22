import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:login_ecommerce/components/models/product.dart';
import 'package:login_ecommerce/features/customer/models/customer_product.dart';
import 'package:login_ecommerce/values.dart/strings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBClient {
  DBClient._();
  static final DBClient dbClient = DBClient._();
  Database database;
  Future<Database> intializeDatabase() async {
    if (database == null) {
      return await connectTodb();
    } else {
      return database;
    }
  }

  Future<Database> connectTodb() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      Database database = await openDatabase(
        join(appDocPath, 'orders.db'),
        version: 1,
        onCreate: (db, version) {
          db.execute('''CREATE TABLE $tableName(
          $productIdColumn TEXT PRIMARY KEY,
          $productNameColumn TEXT NOT NULL,
          $productImageColumn TEXT NOT NULL,
          $productPriceColumn TEXT NOT NULL,
          $countColumn INTEGER NOT NULL
        )''');
        },
      );
      return database;
    } catch (error) {
      print(error);
    }
  }

  Future<List<Map<String, dynamic>>> getAllProductsFromDB() async {
    try {
      database = await intializeDatabase();
      List<Map<String, dynamic>> list = await database.query(tableName);
      return list;
    } catch (error) {
      print(error);
    }
  }

  Future<int> addNewProductToDatabase(DBProduct product) async {
    try {
      database = await intializeDatabase();
      int x = await database.insert(tableName, product.toJson());
      return x;
    } catch (error) {
      print(error);
    }
  }

  deleteProductFormCart(String id) async {
    try {
      database = await intializeDatabase();
      database
          .delete(tableName, where: '$productIdColumn = ?', whereArgs: [id]);
    } catch (error) {
      print(error);
    }
  }

  updateProduct(Product product) async {
    try {
      database = await intializeDatabase();
      product.count++;
      database.update(tableName, product.toJson());
    } catch (error) {
      print(error);
    }
  }
}
