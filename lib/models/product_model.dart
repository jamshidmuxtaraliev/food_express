import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable()
class ProductModel{
  final int id;
  final int restaurant_id;
  final int category_id;
  final String name;
  final String image;
  final double price;
  final List<String> ingridents;
  final String created_at;

  ProductModel(this.id, this.restaurant_id, this.category_id, this.name, this.image, this.price, this.ingridents, this.created_at);

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}