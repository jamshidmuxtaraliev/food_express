import 'package:json_annotation/json_annotation.dart';
part 'base_model.g.dart';

@JsonSerializable()
class BaseModel{
  final bool success;
  final dynamic data;
  final int error_code;
  final String message;
  BaseModel(this.success, this.data, this.error_code, this.message);

  factory BaseModel.fromJson(Map<String, dynamic> json) => _$BaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseModelToJson(this);
}