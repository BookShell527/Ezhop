import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDB {
  AppDB._constructor();
  static final AppDB instance = AppDB._constructor();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'ezhop.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS produk (
        id TEXT PRIMARY KEY, 
        nama TEXT NOT NULL, 
        hargaBeli REAL NOT NULL, 
        hargaJual REAL NOT NULL, 
        jumlahBarang INTEGER NOT NULL
      );''');
    await db.execute('''CREATE TABLE IF NOT EXISTS audit_produk (
          id TEXT PRIMARY KEY, 
          jenisTindakan TEXT NOT NULL,
          idProduk TEXT NOT NULL,
          idRestok TEXT NOT NULL,
          tanggal TEXT NOT NULL,
          namaSebelum TEXT NOT NULL,
          hargaBeliSebelum REAL NOT NULL,
          hargaJualSebelum REAL NOT NULL,
          jumlahBarangSebelum INTEGER NOT NULL,
          namaSetelah TEXT NOT NULL,
          hargaBeliSetelah REAL NOT NULL,
          hargaJualSetelah REAL NOT NULL,
          jumlahBarangSetelah INTEGER NOT NULL
      )''');
    await db.execute('''CREATE TABLE IF NOT EXISTS bundle (
        id TEXT PRIMARY KEY, 
        nama TEXT NOT NULL, 
        hargaJual REAL NOT NULL, 
        hargaBeli REAL NOT NULL
      );''');
    await db.execute('''CREATE TABLE IF NOT EXISTS bundle_produk (
        idBundle TEXT NOT NULL, 
        idProduk TEXT NOT NULL, 
        PRIMARY KEY (idBundle, idProduk)
      );''');
    await db.execute('''CREATE TABLE IF NOT EXISTS catatan_restok (
        id TEXT PRIMARY KEY, 
        nama TEXT NOT NULL, 
        keterangan TEXT, 
        tanggal TEXT NOT NULL
      );''');
    await db.execute('''CREATE TABLE IF NOT EXISTS transaksi (
        id TEXT PRIMARY KEY,
        waktuTransaksi TEXT NOT NULL,
        metodePembayaran TEXT NOT NULL,
        totalHarga REAL NOT NULL,
        uangDiterima REAL NOT NULL,
        uangKembalian REAL NOT NULL
      );''');
    await db.execute('''CREATE TABLE IF NOT EXISTS transaksi_produk (
        idTransaksi TEXT NOT NULL, 
        idProduk TEXT NOT NULL, 
        jumlahBarang INTEGER NOT NULL, 
        hargaJual REAL NOT NULL, 
        PRIMARY KEY (idTransaksi, idProduk)
      );''');
  }
}
