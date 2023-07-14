
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils{
  static SharedPreferences? _prefs;

  static const TOKEN = "token";
  static const CAT_ID = "CAT_ID";

  static initInstance()async{
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setToken(String token){
    return _prefs!.setString(TOKEN, token);
  }

  static String getToken(){
    return _prefs!.getString(TOKEN)??"";
  }

  static Future<bool> setActCat(int cat_id){
    return _prefs!.setInt(CAT_ID, cat_id);
  }

  static int getActCat(){
    return _prefs!.getInt(CAT_ID)??0;
  }
}