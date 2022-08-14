import 'package:json_annotation/json_annotation.dart';

part 'product_item.g.dart';


@JsonSerializable()
class ProductItem {
  @JsonKey(defaultValue: 0, name: 'id')
  int id;

  @JsonKey(defaultValue: 0, name: 'category_id')
  int categoryId;

  @JsonKey(defaultValue: '', name: 'name')
  String name;

  @JsonKey(defaultValue: 0, name: 'price')
  int price;

  @JsonKey(defaultValue: '', name: 'image_url')
  String imageUrl;

  ProductItem({
    required this.id,
    required this.price,
    required this.imageUrl,
    required this.name,
    required this.categoryId,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) =>
      _$ProductItemFromJson(json);

  Map<String, dynamic> toJson() => _$ProductItemToJson(this);

  @override
  String toString() => '''
      id:$id,
      categoryId:$categoryId,
      price:$price,
      imageUrl:$imageUrl,
      name:$name,
  ''';
}
