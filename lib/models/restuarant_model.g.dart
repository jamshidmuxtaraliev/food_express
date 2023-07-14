// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restuarant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestuarantModel _$RestuarantModelFromJson(Map<String, dynamic> json) =>
    RestuarantModel(
      json['id'] as int,
      json['region_id'] as int,
      json['district_id'] as int,
      json['name'] as String,
      json['phone'] as String,
      json['address'] as String,
      json['comment'] as String,
      json['main_image'] as String,
      json['status'] as String,
      json['created_at'] as String,
      (json['latitude'] as num).toDouble(),
      (json['longitude'] as num).toDouble(),
      (json['distance'] as num?)?.toDouble(),
      (json['rating'] as num).toDouble(),
      (json['rating_count'] as num).toDouble(),
      DistrictModel.fromJson(json['district'] as Map<String, dynamic>),
      RegionModel.fromJson(json['region'] as Map<String, dynamic>),
      (json['product_list'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RestuarantModelToJson(RestuarantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'region_id': instance.region_id,
      'district_id': instance.district_id,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'comment': instance.comment,
      'main_image': instance.main_image,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'status': instance.status,
      'created_at': instance.created_at,
      'distance': instance.distance,
      'rating': instance.rating,
      'rating_count': instance.rating_count,
      'district': instance.district,
      'region': instance.region,
      'product_list': instance.product_list,
    };
