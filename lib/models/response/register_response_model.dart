
import 'package:json_annotation/json_annotation.dart';
part 'register_response_model.g.dart';

@JsonSerializable()
class RegisterResponseModel{
  final int id;
  final String token;
  final String fullname;
  final String? avatar;
  final String phone;
  final String status;
  RegisterResponseModel(this.id, this.token, this.fullname, this.avatar, this.phone, this.status);

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => _$RegisterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseModelToJson(this);
}