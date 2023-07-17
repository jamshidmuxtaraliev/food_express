// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
      json['id'] as int,
      json['cart_count'] as int,
      json['name'] as String,
      json['initialPrice'] as double,
      json['image'] as String,
    );

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      'id': instance.id,
      'cart_count': instance.cart_count,
      'name': instance.name,
      'image': instance.image,
      'initialPrice': instance.initialPrice,
    };
