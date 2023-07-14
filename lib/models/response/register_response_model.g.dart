// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponseModel _$RegisterResponseModelFromJson(
        Map<String, dynamic> json) =>
    RegisterResponseModel(
      json['id'] as int,
      json['token'] as String,
      json['fullname'] as String,
      json['avatar'] as String?,
      json['phone'] as String,
      json['status'] as String,
    );

Map<String, dynamic> _$RegisterResponseModelToJson(
        RegisterResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'fullname': instance.fullname,
      'avatar': instance.avatar,
      'phone': instance.phone,
      'status': instance.status,
    };
