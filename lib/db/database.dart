import 'package:sqflite/sqflite.dart';

Database? db;

void initializeDatabase() async {
  db = await openDatabase(
    "ezhop.db",
    onCreate: (Database database, int ver) async {
      await database.execute("CREATE TABLE IF NOT EXISTS produk (id )");
    },
  );
}
