class Produk {
  final String id;
  final String nama;
  final double hargaBeli, hargaJual;
  final int jumlahBarang;
  Produk({
    required this.id,
    required this.nama,
    required this.hargaBeli,
    required this.hargaJual,
    required this.jumlahBarang,
  });
}

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
    required this.id,
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
  }) : tanggal = DateTime.now();
}

class CatatanRestok {
  final String id;
  final String nama;
  final String keterangan;
  final DateTime tanggal;

  CatatanRestok({
    required this.id,
    required this.nama,
    required this.keterangan,
  }) : tanggal = DateTime.now();
}
