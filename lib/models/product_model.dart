import 'package:uuid/uuid.dart';

class Product {
  final String id;
  final String name;
  final double buyPrice;
  final double sellPrice;
  final int stock;

  Product({
    required this.name,
    required this.buyPrice,
    required this.sellPrice,
    required this.stock,
  }) : id = Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'buyPrice': buyPrice,
      'sellPrice': sellPrice,
      'stock': stock,
    };
  }

  static String toTable() {
    return '''
    CREATE TABLE IF NOT EXISTS product (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        buyPrice REAL NOT NULL,
        sellPrice REAL NOT NULL,
        stock INTEGER NOT NULL,
    );
    ''';
  }
}
