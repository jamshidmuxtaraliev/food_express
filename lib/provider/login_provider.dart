import 'package:flutter/cupertino.dart';

class LoginProvider with ChangeNotifier{
  bool _isPrivate = true;
  bool get isPrivate => _isPrivate;

  bool _isLogin = true;
  bool get isLogin => _isLogin;

  void setPrivate(){
    _isPrivate = !_isPrivate;
    notifyListeners();
  }

  void setLoginState(){
    _isLogin = !_isLogin;
    notifyListeners();
  }
}