import 'package:third_exam/data/api/api_provider.dart';
import 'package:third_exam/data/local_data/db/cached_favourite_product.dart';
import 'package:third_exam/data/local_data/db/cached_product.dart';
import 'package:third_exam/data/local_data/db/local_database.dart';
import 'package:third_exam/data/models/category_item.dart';
import 'package:third_exam/data/models/product_item.dart';

class MyRepository {
  MyRepository({
    required this.apiProvider,
  });

  final ApiProvider apiProvider;

  Future<List<ProductItem>> getAllProducts() => apiProvider.getAllProducts();

  Future<List<ProductItem>> getAllCategoryProducts({required int id}) =>
      apiProvider.getCategoryProducts(id: id);

  Future<List<CategoryItem>> getAllCategories() =>
      apiProvider.getAllCategories();

//  -----------------------------------Products------------------------------------------

  Future<CachedProduct> insertCachedProduct(
      {required CachedProduct cachedProduct}) async {
    return await LocalDatabase.insertCachedProduct(cachedProduct);
  }

  Future<List<CachedProduct>> getAllCachedProducts() async {
    return await LocalDatabase.getAllCachedProducts();
  }

  Future<int> deleteCachedProductById({required int id}) async {
    return await LocalDatabase.deleteCachedProductById(id);
  }

  Future<int> updateCachedProductById(
      {required int id, required CachedProduct cachedProduct}) async {
    return await LocalDatabase.updateCachedProduct(
        id: id, cachedProduct: cachedProduct);
  }

  Future<int> updateCachedProductCount(
      {required int id, required int count }) async {
    return await LocalDatabase.updateCachedProductCount(
        id: id, count: count);
  }

  Future<int> clearAllCachedProducts() async {
    return await LocalDatabase.deleteAllCachedProducts();
  }

//  -----------------------------------Products------------------------------------------

  Future<CachedFavouriteProduct> insertFavouriteProduct(
      {required CachedFavouriteProduct favouriteProduct}) async {
    return await LocalDatabase.insertFavouriteProduct(favouriteProduct);
  }

  Future<List<CachedFavouriteProduct>> getAllFavouriteProducts() async {
    return await LocalDatabase.getAllFavouriteProducts();
  }

  Future<int> deleteFavouriteProductById({required int id}) async {
    return await LocalDatabase.deleteFavouriteProductById(id);
  }

  Future<int> clearAllFavouriteProducts() async {
    return await LocalDatabase.deleteAllFavouriteProducts();
  }
}
