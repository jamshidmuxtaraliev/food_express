import 'package:json_annotation/json_annotation.dart';
part 'cart_model.g.dart';

@JsonSerializable()
class CartModel{
   int id;
   int cart_count;
   String name;
   String image;
   double initialPrice;
  CartModel(this.id, this.cart_count, this.name, this.initialPrice, this.image);


  factory CartModel.fromJson(Map<String, dynamic> json) => _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}