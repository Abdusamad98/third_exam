import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:third_exam/data/local_data/db/cached_favourite_product.dart';
import 'package:third_exam/data/local_data/db/cached_product.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();
  static Database? _database;

  factory LocalDatabase() {
    return getInstance;
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("shop_app.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  LocalDatabase._init();

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER DEFAULT 0";

    await db.execute('''
    CREATE TABLE $productsTable (
    ${ProductFields.id} $idType,
    ${ProductFields.count} $intType,
    ${ProductFields.productId} $intType,
    ${ProductFields.imageUrl} $textType,
    ${ProductFields.name} $textType,
    ${ProductFields.price} $intType
    )
    ''');

    await db.execute('''
    CREATE TABLE $favouriteProductsTable (
    ${ProductFields.id} $idType,
    ${ProductFields.productId} $intType,
    ${ProductFields.imageUrl} $textType,
    ${ProductFields.name} $textType,
    ${ProductFields.price} $intType
    )
    ''');
  }

  //-------------------Cached Products Table-------------------

  static Future<CachedProduct> insertCachedProduct(
      CachedProduct cachedProduct) async {
    final db = await getInstance.database;
    final id = await db.insert(productsTable, cachedProduct.toJson());
    return cachedProduct.copyWith(id: id);
  }

  static Future<CachedProduct> getSingleProductById(int id) async {
    final db = await getInstance.database;
    final results = await db.query(
      productsTable,
      columns: ProductFields.values,
      where: '${ProductFields.id} = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return CachedProduct.fromJson(results.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  static Future<List<CachedProduct>> getAllCachedProducts() async {
    final db = await getInstance.database;
    const orderBy = "${ProductFields.name} ASC";
    final result = await db.query(
      productsTable,
      orderBy: orderBy,
    );
    return result.map((json) => CachedProduct.fromJson(json)).toList();
  }

  static Future<int> deleteAllCachedProducts() async {
    final db = await getInstance.database;
    return await db.delete(productsTable);
  }

  static Future<int> deleteCachedProductById(int id) async {
    final db = await getInstance.database;
    var t = await db
        .delete(productsTable, where: "${ProductFields.id}=?", whereArgs: [id]);
    if (t > 0) {
      return t;
    } else {
      return -1;
    }
  }

  static Future<int> updateCachedProduct(
      {required int id, required CachedProduct cachedProduct}) async {
    Map<String, dynamic> row = {
      ProductFields.name: cachedProduct.name,
      ProductFields.price: cachedProduct.price,
      ProductFields.count: cachedProduct.count,
      ProductFields.productId: cachedProduct.productId,
      ProductFields.imageUrl: cachedProduct.imageUrl,
    };
    final db = await getInstance.database;
    return db.update(
      productsTable,
      row,
      where: '${ProductFields.id} = ?',
      whereArgs: [id],
    );
  }

  static Future<int> updateCachedProductCount(
      {required int id, required int count}) async {
    Map<String, dynamic> row = {
      ProductFields.count: count,
    };
    final db = await getInstance.database;
    return db.update(
      productsTable,
      row,
      where: '${ProductFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await getInstance.database;
    db.close();
  }

  //-------------------Cached Favourite Products Table-------------------

  static Future<CachedFavouriteProduct> insertFavouriteProduct(
      CachedFavouriteProduct cachedFavouriteProduct) async {
    final db = await getInstance.database;
    final id = await db.insert(
        favouriteProductsTable, cachedFavouriteProduct.toJson());
    return cachedFavouriteProduct.copyWith(id: id);
  }

  static Future<List<CachedFavouriteProduct>> getAllFavouriteProducts() async {
    final db = await getInstance.database;
    const orderBy = "${ProductFields.name} ASC";
    final result = await db.query(
      favouriteProductsTable,
      orderBy: orderBy,
    );
    return result.map((json) => CachedFavouriteProduct.fromJson(json)).toList();
  }

  static Future<int> deleteAllFavouriteProducts() async {
    final db = await getInstance.database;
    return await db.delete(favouriteProductsTable);
  }

  static Future<int> deleteFavouriteProductById(int id) async {
    final db = await getInstance.database;
    var t = await db.delete(favouriteProductsTable,
        where: "${ProductFields.id}=?", whereArgs: [id]);
    if (t > 0) {
      return t;
    } else {
      return -1;
    }
  }
}
