import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:food_express/main.dart';
import 'package:food_express/models/base_model.dart';
import 'package:food_express/models/restuarant_model.dart';
import 'package:food_express/utils/constants.dart';
import 'package:food_express/utils/pref_utils.dart';

import '../models/offer_model.dart';
import '../models/response/register_response_model.dart';

class ApiServices {
  final dio = Dio();

  ApiServices() {
    dio.options.baseUrl = BASE_URL;
    dio.options.headers.addAll({
      'Key': DEVELOPER_KEY,
      'Content-Type': 'application/json',
      // 'token': PrefUtils.getToken(),
      'Token': PrefUtils.getToken(),
      'Connection': "close",
    });
    dio.interceptors.add(MyApp.alice.getDioInterceptor());
  }

  BaseModel wrapResponse(Response response) {
    if (response.statusCode == 200) {
      final data = BaseModel.fromJson(response.data);
      if (data.success) {
        return data;
      } else {
        if (data.error_code == 405) {
          /* Eventbus ga 405 Log Out berib yuboriladi ! */
        }
      }
      return data;
    } else {
      return BaseModel(false, null, -1, response.statusMessage ?? "Oops! \n Unknown Error!");
    }
  }

  String wrapError(DioException error) {
    if (kDebugMode) {
      return error.message ?? "Unknown Error !";
    }

    switch (error.type) {
      case DioExceptionType.unknown:
        return "Nomalum xatoliklar yuz berdi.";
      case DioExceptionType.badCertificate:
        return "Server bilan xavfsiz aloqa o'rnatib bo'lmadi";
      case DioExceptionType.badResponse:
        return "Serverdan yaroqsiz javob qaytmoqda!";
      case DioExceptionType.sendTimeout:
        return "Serverga murojaat qilish vaqti tugadi. \n Tarmoqa ulanishda muammo";
      case DioExceptionType.connectionError:
        return "Tarmoqqa ulanishda muammo yuz berdi. \n Iltimos internetga ulanishni tekshiring";
      case DioExceptionType.connectionTimeout:
        return "Kutish vaqti tugadi. \n Tarmoqa ulanishda muammo";
      case DioExceptionType.cancel:
        return "Nomalum xatolik yuz berdi";
      default:
        "Nomalum xatolik yuz berdi";
    }
    return error.message ?? "Unknown error";
  }

  Future<RegisterResponseModel?> register(
      String fullname, String phone, String password, StreamController<String> errorStream) async {
    try {
      final response = await dio.post("registration",
          data: jsonEncode({'fullname': fullname, 'phone': phone, 'password': password}));
      final baseData = wrapResponse(response);
      if (baseData.success) {
        return RegisterResponseModel.fromJson(baseData.data);
      } else {
        errorStream.sink.add(baseData.message);
      }
    } on DioException catch (e) {
      errorStream.sink.add(e.toString());
    }
    return null;
  }

  Future<RegisterResponseModel?> login(
      String phone, String password, StreamController<String> errorStream) async {
    try {
      final response = await dio.post("login",
          data: jsonEncode({
            'phone': phone,
            'password': password,
          }));
      final baseData = wrapResponse(response);
      if (baseData.success) {
        return RegisterResponseModel.fromJson(baseData.data);
      } else {
        errorStream.sink.add(baseData.message);
      }
    } on DioException catch (e) {
      errorStream.sink.add(e.toString());
    }
    return null;
  }

  Future<List<OfferModel>?> offers(StreamController<String> errorStream) async {
    try {
      final response = await dio.get("offers");
      final baseData = wrapResponse(response);
      if (baseData.success) {
        return (baseData.data as List<dynamic>).map((e) => OfferModel.fromJson(e)).toList();
      } else {
        errorStream.sink.add(baseData.message);
      }
    } on DioException catch (e) {
      errorStream.sink.add(e.toString());
    }
    return null;
  }

  Future<OfferModel?> oneOffer(int offerId, StreamController<String> errorStream) async {
    try {
      final response = await dio.get("offer/$offerId/content");
      final baseData = wrapResponse(response);
      if (baseData.success) {
        return OfferModel.fromJson(baseData.data);
      } else {
        errorStream.sink.add(baseData.message);
      }
    } on DioException catch (e) {
      errorStream.sink.add(e.toString());
    }
    return null;
  }

  Future<List<OfferModel>?> categories(StreamController<String> errorStream) async {
    try {
      final response = await dio.get("categories");
      final baseData = wrapResponse(response);
      if (baseData.success) {
        return (baseData.data as List<dynamic>).map((e) => OfferModel.fromJson(e)).toList();
      } else {
        errorStream.sink.add(baseData.message);
      }
    } on DioException catch (e) {
      errorStream.sink.add(e.toString());
    }
    return null;
  }

  Future<List<RestuarantModel>?> nearRestuarants(
      int region_id,
      int district_id,
      int category_id,
      int food_id,
      String keyword,
      String sort,
      int limit,
      double latitude,
      double longitude,
      StreamController<String> errorStream) async {
    try {
      final response = await dio.post("restaurants",
          data: jsonEncode({
            'region_id': region_id,
            'district_id': district_id,
            'category_id': category_id,
            'food_id': food_id,
            'keyword': keyword,
            'sort': sort,
            'limit': limit,
            'latitude': latitude,
            'longitude': longitude,
          }));
      final baseData = wrapResponse(response);
      if (baseData.success) {
        return (baseData.data as List<dynamic>).map((e) => RestuarantModel.fromJson(e)).toList();
      } else {
        errorStream.sink.add(baseData.message);
      }
    } on DioException catch (e) {
      errorStream.sink.add(e.toString());
    }
    return [];
  }

  Future<List<RestuarantModel>?> topRestuarants(
      int region_id,
      int district_id,
      int category_id,
      int food_id,
      String keyword,
      String sort,
      int limit,
      double latitude,
      double longitude,
      StreamController<String> errorStream) async {
    try {
      final response = await dio.post("restaurants",
          data: jsonEncode({
            'region_id': region_id,
            'district_id': district_id,
            'category_id': category_id,
            'food_id': food_id,
            'keyword': keyword,
            'sort': sort,
            'limit': limit,
            'latitude': latitude,
            'longitude': longitude,
          }));
      final baseData = wrapResponse(response);
      if (baseData.success) {
        return (baseData.data as List<dynamic>).map((e) => RestuarantModel.fromJson(e)).toList();
      } else {
        errorStream.sink.add(baseData.message);
      }
    } on DioException catch (e) {
      errorStream.sink.add(e.toString());
    }
    return [];
  }



  Future<bool?> makeRatingRestaurant(
      int restaurant_id,
      double rating,
      String comment,
      StreamController<String> errorStream) async {
    try {
      final response = await dio.post("make_rating",
          data: jsonEncode({
            'restaurant_id': restaurant_id,
            'rating':rating,
            'comment':comment
          }));
      final baseData = wrapResponse(response);
      if (baseData.success) {
        return true;
      } else {
        errorStream.sink.add(baseData.message);
      }
    } on DioException catch (e) {
      errorStream.sink.add(e.toString());
    }
    return null;
  }
}
