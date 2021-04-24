import 'package:projeto_formulario/model/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProductHelper {

  final String productTable = 'productTable';
  final String idColumn = 'id_column';
  final String ipColumn = 'ip_column';
  final String descriptionColumn = 'description_column';
  final String familyColumn = 'family_column';
  final String standardColumn = 'standard_column';
  final String typeColumn = 'type_column';

  static final ProductHelper _instance = ProductHelper.internal();

  factory ProductHelper() => _instance;

  ProductHelper.internal();

  Database _database;

  initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "products.db");

    return openDatabase(path, version: 1,
        onCreate: (Database database, int newerVersion) async {
          await database.execute(
              "CREATE TABLE $productTable("
                  "$idColumn INTEGER PRIMARY KEY,"
                  "$ipColumn TEXT,"
                  "$descriptionColumn TEXT,"
                  "$familyColumn TEXT,"
                  "$standardColumn TEXT,"
                  "$typeColumn TEXT)"
          );
        });
  }

  Future<Database> get database async {
    if (_database != null)
      return _database;
    _database = await initDatabase();
    return _database;
  }

  Future<Product> save(Product product) async {
    Database databaseProduct = await database;
    product.id = await databaseProduct.insert(productTable, product.toMap());
  }

  Future close() async {
    Database databaseProduct = await database;
    databaseProduct.close();
  }

  Future<List<Product>> fetchAll() async {
    Database databaseProduct = await database;
    List listMap = await databaseProduct.query(productTable,
        columns: [idColumn, ipColumn, descriptionColumn, familyColumn, standardColumn, typeColumn],
    );

    List<Product> listProduct = [];
    for(Map map in listMap) {
      listProduct.add(Product.fromMap(map));  //fetch all dale
    }

    if (listProduct.isNotEmpty)
      return listProduct;
    else
      return null;
  }

  Future<Product> findByIp(int ip) async {
    Database databaseProduct = await database;
    List<Map> maps = await databaseProduct.query(productTable,
        columns: [
          idColumn,
          ipColumn,
          descriptionColumn,
          familyColumn,
          standardColumn,
          typeColumn
        ],
        where: '$ipColumn = ?',
        whereArgs: [ip]
    );

    if (maps.length > 0)
      return Product.fromMap(maps.first);
    else
      return null;
  }

  Future<int> delete(int id) async {
    Database databaseProduct = await database;
    return await databaseProduct.delete(productTable,
        where: '$idColumn = ?',
        whereArgs: [id]
    );
  }

  Future<int> update(Product product) async {
    Database databaseProduct = await database;
    return await databaseProduct.update(
        productTable,
        product.toMap(),
        where: '$idColumn = ?',
        whereArgs: [product.id]
    );
  }

  Future<int> getSize() async {
    Database databaseProduct = await database;
    return Sqflite.firstIntValue(await databaseProduct.rawQuery('select count (*) from $productTable'));
  }
}