import 'package:third_exam/data/local_data/db/cached_product.dart';

const String favouriteProductsTable = "cached_favourite_products";

class CachedFavouriteProduct {
  final int? id;
  final int productId;
  final String name;
  final int price;
  final String imageUrl;

  CachedFavouriteProduct({
    this.id,
    required this.imageUrl,
    required this.price,
    required this.name,
    required this.productId,
  });

  CachedFavouriteProduct copyWith({
    int? id,
    int? productId,
    int? price,
    String? name,
    String? imageUrl,
  }) =>
      CachedFavouriteProduct(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        price: price ?? this.price,
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  static CachedFavouriteProduct fromJson(Map<String, Object?> json) =>
      CachedFavouriteProduct(
        id: json[ProductFields.id] as int?,
        productId: json[ProductFields.productId] as int,
        price: json[ProductFields.price] as int,
        name: json[ProductFields.name] as String,
        imageUrl: json[ProductFields.imageUrl] as String,
      );

  Map<String, Object?> toJson() => {
    ProductFields.id: id,
    ProductFields.productId: productId,
    ProductFields.price: price,
    ProductFields.name: name,
    ProductFields.imageUrl: imageUrl,
      };

  @override
  String toString() => '''
        ID: $id 
        PRODUCT ID $productId
        PRICE $price
        NAME $name
        IMAGE URL $imageUrl
      ''';
}
