// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      json['id'] as int,
      json['restaurant_id'] as int,
      json['category_id'] as int,
      json['name'] as String,
      json['image'] as String,
      (json['price'] as num).toDouble(),
      (json['ingridents'] as List<dynamic>).map((e) => e as String).toList(),
      json['created_at'] as String,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'restaurant_id': instance.restaurant_id,
      'category_id': instance.category_id,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'ingridents': instance.ingridents,
      'created_at': instance.created_at,
    };
