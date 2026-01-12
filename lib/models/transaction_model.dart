import 'package:uuid/uuid.dart';

class Transactions {
  final String id;
  final DateTime datetime;
  final double totalPrice;
  final String paymentMethod;
  final double paidPrice;
  final double changePrice;

  Transactions({
    required this.datetime,
    required this.totalPrice,
    required this.paymentMethod,
    required this.paidPrice,
    required this.changePrice,
  }) : id = Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "datetime": datetime.toIso8601String(),
      "totalPrice": totalPrice,
      "paymentMethod": paymentMethod,
      "paidPrice": paidPrice,
      "changePrice": changePrice,
    };
  }

  static String toTable() {
    return '''
    CREATE TABLE IF NOT EXISTS transaction (
        id TEXT PRIMARY KEY,
        datetime TEXT NOT NULL,
        totalPrice REAL NOT NULL,
        paymentMethod TEXT NOT NULL,
        paidPrice REAL NOT NULL,
        changePrice REAL NOT NULL,
    );
    ''';
  }
}
