import 'package:json_annotation/json_annotation.dart';
part 'offer_model.g.dart';

@JsonSerializable()
class OfferModel{
  final int id;
  final String? title;
  final String? image;
  OfferModel(this.id, this.title, this.image);

  factory OfferModel.fromJson(Map<String, dynamic> json) => _$OfferModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferModelToJson(this);
}