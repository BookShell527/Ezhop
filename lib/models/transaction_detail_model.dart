import 'package:uuid/uuid.dart';

class TransactionDetail {
  final String id;
  final double subtotalPrice;
  final int quantity;
  final double unitPrice;
  TransactionDetail({
    required this.subtotalPrice,
    required this.quantity,
    required this.unitPrice,
  }) : id = Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "subtotalPrice": subtotalPrice,
      "quantity": quantity,
      "unitPrice": unitPrice,
    };
  }

  static String toTable() {
    return '''
    CREATE TABLE IF NOT EXISTS transaction_detail (
        id TEXT PRIMARY KEY,
        subtotalPrice REAL NOT NULL,
        quantity INTEGER NOT NULL,
        unitPrice REAL NOT NULL
    );
    ''';
  }
}
