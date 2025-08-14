import 'dart:developer';

import 'package:sqflite/sqflite.dart';

class SqlService {
  static late Database database;
  static Future<void> initDb() async {
    database = await openDatabase(
      "cart.db",
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE cart (id INTEGER PRIMARY KEY, title TEXT, img TEXT, qty INTEGER, price REAL)');
      },
    );
  }

  static Future<List<Map>> getData() async {
    List<Map> data = await database.query('cart');
    log(data.toString());
    return data;
  }

  static Future<void> addData(Map<String, dynamic> data) async {
    await database.insert("cart", data);
  }

  static Future<void> editData(
      {required int qty, required int productId}) async {
    await database.update("cart", {"qty": qty},
        where: 'id = ?', whereArgs: [productId]);
  }

  static Future<void> deleteData(int productId) async {
    await database.delete("cart", where: 'id = ?', whereArgs: [productId]);
  }
}
