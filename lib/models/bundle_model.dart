class Bundle {
  final String id;
  final String nama;
  final double hargaJual;
  final double hargaBeli;

  Bundle({
    required this.id,
    required this.nama,
    required this.hargaJual,
    required this.hargaBeli,
  });
}

class BundleProduk {
  final String idBundle;
  final String idProduk;

  BundleProduk({required this.idBundle, required this.idProduk});
}
