import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ezhop/models/product_model.dart';
import 'package:ezhop/models/transaction_detail_model.dart';
import 'package:ezhop/models/transaction_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DBHelper {
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();
  static Database? _db;
  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String dbpath = join(dir.path, 'ezhop.db');
    return await openDatabase(dbpath, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database database, int version) async {
    await database.execute(Product.toTable());
    await database.execute(Transactions.toTable());
    await database.execute(TransactionDetail.toTable());
  }
}
