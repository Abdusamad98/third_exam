import 'package:json_annotation/json_annotation.dart';

part 'category_item.g.dart';


@JsonSerializable()
class CategoryItem {
  @JsonKey(defaultValue: 0, name: 'id')
  int id;

  @JsonKey(defaultValue: '', name: 'name')
  String name;

  @JsonKey(defaultValue: '', name: 'image_url')
  String imageUrl;

  CategoryItem({
    required this.id,
    required this.imageUrl,
    required this.name,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) =>
      _$CategoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryItemToJson(this);

  @override
  String toString() => '''
      id:$id,
      imageUrl:$imageUrl,
      name:$name,
  ''';
}
