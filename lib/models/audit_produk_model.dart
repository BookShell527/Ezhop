import 'package:uuid/uuid.dart';

enum JenisTindakan { restok, tambah, hapus, edit }

class AuditProduk {
  final String id;
  final JenisTindakan jenisTindakan;
  final String idProduk;
  final String idRestok;
  final DateTime tanggal;

  final String namaSebelum;
  final double hargaBeliSebelum;
  final double hargaJualSebelum;
  final int jumlahBarangSebelum;

  final String namaSetelah;
  final double hargaBeliSetelah;
  final double hargaJualSetelah;
  final int jumlahBarangSetelah;

  AuditProduk({
    required this.idRestok,
    required this.idProduk,
    required this.jenisTindakan,

    required this.namaSebelum,
    required this.hargaBeliSebelum,
    required this.hargaJualSebelum,
    required this.jumlahBarangSebelum,

    required this.namaSetelah,
    required this.hargaBeliSetelah,
    required this.hargaJualSetelah,
    required this.jumlahBarangSetelah,
  }) : tanggal = DateTime.now(),
       id = Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idProduk': idProduk,
      'idRestok': idRestok,
      'jenisTindakan': jenisTindakan.name,
      'tanggal': tanggal.toIso8601String(),

      'namaSebelum': namaSebelum,
      'hargaBeliSebelum': hargaBeliSebelum,
      'hargaJualSebelum': hargaJualSebelum,
      'jumlahBarangSebelum': jumlahBarangSebelum,

      'namaSetelah': namaSetelah,
      'hargaBeliSetelah': hargaBeliSetelah,
      'hargaJualSetelah': hargaJualSetelah,
      'jumlahBarangSetelah': jumlahBarangSetelah,
    };
  }
}
