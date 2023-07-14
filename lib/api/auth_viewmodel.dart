import 'dart:async';

import 'package:food_express/api/api_services.dart';
import 'package:food_express/utils/pref_utils.dart';
import 'package:stacked/stacked.dart';

import '../models/response/register_response_model.dart';

class AuthViewModel extends BaseViewModel {
  final api = ApiServices();
  var isProgress = false;

  StreamController<String> _errorStream = StreamController();

  Stream<String> get errorData {
    return _errorStream.stream;
  }

  StreamController<RegisterResponseModel> _registerStream = StreamController();

  Stream<RegisterResponseModel> get registerData {
    return _registerStream.stream;
  }

  void register(String phone, String fullname, String password)async{
    isProgress = true;
    notifyListeners();
    final data = await api.register(fullname, phone, password, _errorStream);
    isProgress = false;
    notifyListeners();
    if (data != null) {
      PrefUtils.setToken(data.token);
      _registerStream.sink.add(data);
    }
  }

  void login(String phone, String password)async{
    isProgress = true;
    notifyListeners();
    final data = await api.login(phone, password, _errorStream);
    isProgress = false;
    notifyListeners();
    if (data != null) {
      PrefUtils.setToken(data.token);
      _registerStream.sink.add(data);
    }
  }
}
