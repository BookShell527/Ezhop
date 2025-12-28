import 'package:uuid/uuid.dart';

class CatatanRestok {
  final String id;
  final String nama;
  final String keterangan;
  final DateTime tanggal;

  CatatanRestok({required this.nama, required this.keterangan})
    : tanggal = DateTime.now(),
      id = Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nama": nama,
      "keterangan": keterangan,
      "tanggal": tanggal,
    };
  }
}
