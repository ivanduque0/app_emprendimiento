import 'package:app_emprendimiento/order/domain/models/order.dart';
import 'package:app_emprendimiento/stock/domain/models/item.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _dbName = "main_db";
  static final String _itemsTable = "items";
  static final String _ordersTable = "orders";

  static Future initDb() async {
    if (_db !=null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + "${_dbName}.db";
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          //print("creando database xd");
          db.execute('''
            CREATE TABLE IF NOT EXISTS $_itemsTable (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              price STRING,
              photo STRING,
              quantity INT
            )''');
          db.execute('''
            CREATE TABLE IF NOT EXISTS $_ordersTable (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              note TEXT,
              to_pay STRING,
              paid STRING,
              products STRING,
              date STRING,
              time STRING,
              remind INTEGER,
              color INTEGER,
              is_completed INTEGER
            )'''
          );
        },
      );
    } catch (e) {
      
    }
  }

  static Future<int> insertItem(Item item) async {
    return await _db!.insert(_itemsTable, item.toJson());
  }

  static Future<List> queryItems() async {
    return await _db!.query(_itemsTable);
  }

  static Future<int> updateItem(Item item) async {
    return await _db!.update(_itemsTable, item.toJson(),
      where: 'id = ?', whereArgs: [item.id]);
  }

  static Future<int> deleteItem(int id) async {
    return await _db!.delete(_itemsTable, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> insertOrder(Order order) async {
    return await _db!.insert(_ordersTable, order.toJson());
  }

   static Future<List> queryOrders() async {
    return await _db!.query(_ordersTable);
  }

  static Future<int> updateOrder(Order order) async {
    return await _db!.update(_ordersTable, order.toJson(),
      where: 'id = ?', whereArgs: [order.id]);
  }

  static Future<int> deleteOrder(int id) async {
    return await _db!.delete(_ordersTable, where: 'id = ?', whereArgs: [id]);
  }
  
}