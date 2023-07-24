import 'dart:convert';

import 'package:food_express/models/response/register_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_model.dart';

class PrefUtils {
  static SharedPreferences? _prefs;

  static const TOKEN = "token";
  static const CAT_ID = "CAT_ID";
  static const USERDATA = "USERDATA";
  static const CART = "CART";

  static initInstance() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setToken(String token) {
    return _prefs!.setString(TOKEN, token);
  }

  static String getToken() {
    return _prefs!.getString(TOKEN) ?? "";
  }
  
  static Future<bool> setUserData(RegisterResponseModel userData) {
    return _prefs!.setString(USERDATA, jsonEncode(userData.toJson()));
  }

  static RegisterResponseModel? getUserData() {
    if (_prefs?.getString(USERDATA) == null) {
      return null;
    }  else{
      return RegisterResponseModel.fromJson(jsonDecode(_prefs?.getString(USERDATA)??""));
    }
  }

  static Future<bool> setActCat(int cat_id) {
    return _prefs!.setInt(CAT_ID, cat_id);
  }

  static int getActCat() {
    return _prefs!.getInt(CAT_ID) ?? 0;
  }

  static List<CartModel> getCartList() {
    var json = _prefs?.getString(CART);

    if (json == null) {
      return [];
    }

    var items = (jsonDecode(json) as List<dynamic>).map((e) => CartModel.fromJson(e)).toList();
    return items;
  }

  static Future<bool> setCartList(List<CartModel> cartList) async {
    var result = await _prefs!.setString(CART, jsonEncode(cartList.map((e) => e.toJson()).toList()));
    return result;
  }

  static void clearAll() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

}