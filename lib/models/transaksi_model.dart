enum PaymentMethod { cash, qris, transferBank }

class Transaction {
  final String id;
  final DateTime waktuTransaksi;
  final PaymentMethod metodePembayaran;
  final double totalHarga;
  final double uangDiterima;
  final double uangKembalian;
  Transaction({
    required this.id,
    required this.metodePembayaran,
    required this.totalHarga,
    required this.uangDiterima,
    required this.uangKembalian,
  }) : waktuTransaksi = DateTime.now();

  String get metode {
    switch (metodePembayaran) {
      case PaymentMethod.cash:
        return "Cash";
      case PaymentMethod.qris:
        return "Qris";
      case PaymentMethod.transferBank:
        return "Transfer Bank";
    }
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
}
