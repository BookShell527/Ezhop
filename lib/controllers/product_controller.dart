import 'dart:async';
import 'package:ezhop/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ezhop/db.dart';

class ProductController extends AsyncNotifier<List<Product>> {
  final DBHelper _dbHelper = DBHelper.instance;
  @override
  FutureOr<List<Product>> build() async {
    return _fetchProduct();
  }

  Future<Product?> getProduct(String id) async {
    final db = await _dbHelper.db;
    final productMap = await db.query(
      'product',
      where: 'id = ?',
      whereArgs: [id],
    );
    final result = productMap.map((map) => Product.fromMap(map)).toList();
    return result[0];
  }

  Future<void> insertProduct(Product product) async {
    state = await AsyncValue.guard(() async {
      final db = await _dbHelper.db;
      await db.insert('product', product.toMap());
      return _fetchProduct();
    });
  }

  Future<void> deleteProduct(String id) async {
    state = await AsyncValue.guard(() async {
      final db = await _dbHelper.db;
      await db.delete('product', where: 'id = ?', whereArgs: [id]);
      return _fetchProduct();
    });
  }

  Future<void> updateProduct(Product product) async {
    state = await AsyncValue.guard(() async {
      final db = await _dbHelper.db;
      await db.update(
        'product',
        product.toMap(),
        where: 'id = ?',
        whereArgs: [product.id],
      );
      return _fetchProduct();
    });
  }

  Future<List<Product>> _fetchProduct() async {
    final db = await _dbHelper.db;
    final result = await db.query('product');
    return result.map((map) => Product.fromMap(map)).toList();
  }
}

final productController =
    AsyncNotifierProvider<ProductController, List<Product>>(() {
      return ProductController();
    });
