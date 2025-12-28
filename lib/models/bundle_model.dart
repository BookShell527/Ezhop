import 'package:uuid/uuid.dart';

class Bundle {
  final String id;
  final String nama;
  final double hargaJual;
  final double hargaBeli;

  Bundle({required this.nama, required this.hargaJual, required this.hargaBeli})
    : id = Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nama": nama,
      "hargaJual": hargaJual,
      "hargaBeli": hargaBeli,
    };
  }
}

class BundleProduk {
  final String idBundle;
  final String idProduk;

  BundleProduk({required this.idBundle, required this.idProduk});

  Map<String, dynamic> toMap() {
    return {"idBundle": idBundle, "idProduk": idProduk};
  }
}
