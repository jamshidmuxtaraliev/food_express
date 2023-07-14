import 'package:json_annotation/json_annotation.dart';
part 'region_model.g.dart';

@JsonSerializable()
class RegionModel{
  final int id;
  final String region_name;
  RegionModel(this.id, this.region_name);

  factory RegionModel.fromJson(Map<String, dynamic> json) => _$RegionModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegionModelToJson(this);
}