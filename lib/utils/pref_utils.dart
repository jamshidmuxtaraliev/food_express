
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils{
  static SharedPreferences? _prefs;

  static const TOKEN = "token";

  static initInstance()async{
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setToken(String token){
    return _prefs!.setString(TOKEN, token);
  }

  static String getToken(){
    return _prefs!.getString(TOKEN)??"";
  }
}