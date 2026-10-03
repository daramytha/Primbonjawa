import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDbHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  static Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'primbon_tafsir.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tafsir_mimpi (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            keyword TEXT NOT NULL,
            tafsir TEXT NOT NULL,
            kategori TEXT NOT NULL
          )
        ''');

        await db.rawInsert('''
          INSERT INTO tafsir_mimpi (keyword, tafsir, kategori) VALUES
          ('Ular', 'Mimpi melihat ular melambangkan adanya rintangan, atau penanda akan datangnya jodoh jika bermimpi digigit ular.', 'Hewan'),
          ('Air Jernih', 'Pertanda keberkahan, ketenangan pikiran, dan rezeki yang lancar serta halal.', 'Alam'),
          ('Terbang', 'Pertanda keinginan untuk bebas, peningkatan derajat, atau kesuksesan karir.', 'Pengalaman'),
          ('Pernikahan', 'Pertanda adanya komitmen baru atau fase kehidupan baru yang memerlukan tanggung jawab.', 'Kehidupan'),
          ('Gigi Copot', 'Peringatan untuk lebih memperhatikan kesehatan diri sendiri atau anggota keluarga.', 'Tubuh')
        ''');
      },
    );
  }

  static Future<List<Map<String, dynamic>>> searchTafsir(String query) async {
    final db = await database;
    if (query.isEmpty) return await db.query('tafsir_mimpi');
    return await db.query(
      'tafsir_mimpi',
      where: 'keyword LIKE ? OR tafsir LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
  }
}
