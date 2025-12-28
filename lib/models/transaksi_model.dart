import 'package:uuid/uuid.dart';

enum PaymentMethod { cash, qris, transferBank }

class Transaction {
  final String id;
  final DateTime waktuTransaksi;
  final PaymentMethod metodePembayaran;
  final double totalHarga;
  final double uangDiterima;
  final double uangKembalian;

  Transaction({
    required this.metodePembayaran,
    required this.totalHarga,
    required this.uangDiterima,
    required this.uangKembalian,
  }) : waktuTransaksi = DateTime.now(),
       id = Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "waktuTransaksi": waktuTransaksi.toIso8601String(),
      "metodePembayaran": metodePembayaran.name,
      "totalHarga": totalHarga,
      "uangDiterima": uangDiterima,
      "uangKembalian": uangKembalian,
    };
  }
}

class TransactionProduk {
  final String idTransaksi;
  final String idProduk;
  final int jumlahBarang;
  final double hargaJual;

  TransactionProduk({
    required this.idTransaksi,
    required this.idProduk,
    required this.jumlahBarang,
    required this.hargaJual,
  });

  double get subtotal => hargaJual * jumlahBarang;

  Map<String, dynamic> toMap() {
    return {
      "idTransaksi": idTransaksi,
      "idProduk": idProduk,
      "jumlahBarang": jumlahBarang,
      "hargaJual": hargaJual,
    };
  }
}
