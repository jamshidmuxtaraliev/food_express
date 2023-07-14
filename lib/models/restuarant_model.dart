import 'package:food_express/models/product_model.dart';
import 'package:food_express/models/region_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'district_model.dart';
part 'restuarant_model.g.dart';

@JsonSerializable()
class RestuarantModel{
  final int id;
  final int region_id;
  final int district_id;
  final String name;
  final String phone;
  final String address;
  final String comment;
  final String main_image;
  final double latitude;
  final double longitude;
  final String status;
  final String created_at;
  final double? distance;
  final double rating;
  final double rating_count;
  final DistrictModel district;
  final RegionModel region;
  final List<ProductModel>? product_list;

  RestuarantModel(this.id, this.region_id, this.district_id, this.name, this.phone, this.address, this.comment, this.main_image, this.status, this.created_at, this.latitude, this.longitude, this.distance, this.rating, this.rating_count, this.district, this.region, this.product_list, );

  factory RestuarantModel.fromJson(Map<String, dynamic> json) => _$RestuarantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestuarantModelToJson(this);
}