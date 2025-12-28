import 'package:uuid/uuid.dart';

class Produk {
  final String id;
  final String nama;
  final double hargaBeli, hargaJual;
  final int jumlahBarang;

  Produk({
    required this.nama,
    required this.hargaBeli,
    required this.hargaJual,
    required this.jumlahBarang,
  }) : id = Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'hargaBeli': hargaBeli,
      'hargaJual': hargaJual,
      'jumlahBarang': jumlahBarang,
    };
  }
}
