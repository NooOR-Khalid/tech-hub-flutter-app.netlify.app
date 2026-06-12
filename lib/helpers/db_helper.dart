import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  // دالة لفتح قاعدة البيانات
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'cart.db'),
      onCreate: (db, version) {
        // إنشاء جدول السلة (cart_items)
        return db.execute(
          'CREATE TABLE cart_items(id TEXT PRIMARY KEY, title TEXT, price REAL, image TEXT, quantity INTEGER)',
        );
      },
      version: 1,
    );
  }

  // دالة إدراج منتج
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  // دالة تحديث منتج (مضافة حديثاً)
  static Future<void> update(
    String table,
    String id,
    Map<String, dynamic> data,
  ) async {
    final db = await DBHelper.database();
    await db.update(table, data, where: 'id = ?', whereArgs: [id]);
  }

  // دالة لجلب البيانات
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  // دالة حذف منتج
  static Future<void> delete(String table, String id) async {
    final db = await DBHelper.database();
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
