import 'package:json_annotation/json_annotation.dart';
part 'district_model.g.dart';

@JsonSerializable()
class DistrictModel{
  final int id;
  final int region_id;
  final String district_name;
  DistrictModel(this.id, this.region_id, this.district_name);

  factory DistrictModel.fromJson(Map<String, dynamic> json) => _$DistrictModelFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictModelToJson(this);
}
