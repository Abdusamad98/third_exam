const String productsTable = "cached_products";

class ProductFields {
  static final List<String> values = [
    /// Add all fields
    id, productId, count, name, price, imageUrl,
  ];
  static const String id = "_id";
  static const String productId = "product_id";
  static const String count = "count";
  static const String name = "name";
  static const String price = "price";
  static const String imageUrl = "image_url";
}

class CachedProduct {
  final int? id;
  final int productId;
  final int count;
  final String name;
  final int price;
  final String imageUrl;

  CachedProduct({
    this.id,
    required this.imageUrl,
    required this.price,
    required this.count,
    required this.name,
    required this.productId,
  });

  CachedProduct copyWith({
    int? id,
    int? productId,
    int? count,
    int? price,
    String? name,
    String? imageUrl,
  }) =>
      CachedProduct(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        count: count ?? this.count,
        price: price ?? this.price,
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  static CachedProduct fromJson(Map<String, Object?> json) => CachedProduct(
        id: json[ProductFields.id] as int?,
        productId: json[ProductFields.productId] as int,
        count: json[ProductFields.count] as int,
        price: json[ProductFields.price] as int,
        name: json[ProductFields.name] as String,
        imageUrl: json[ProductFields.imageUrl] as String,
      );

  Map<String, Object?> toJson() => {
        ProductFields.id: id,
        ProductFields.productId: productId,
        ProductFields.count: count,
        ProductFields.price: price,
        ProductFields.name: name,
        ProductFields.imageUrl: imageUrl,
      };

  @override
  String toString() => '''
        ID: $id 
        COUNT $count
        PRODUCT ID $productId
        PRICE $price
        NAME $name
        IMAGE URL $imageUrl
      ''';
}
