import 'dart:async';
import 'package:food_express/api/api_services.dart';
import 'package:food_express/models/restuarant_model.dart';
import 'package:stacked/stacked.dart';
import '../models/offer_model.dart';

class MainViewModel extends BaseViewModel {
  final api = ApiServices();
  var isProgress = false;

  StreamController<String> _errorStream = StreamController();

  Stream<String> get errorData {
    return _errorStream.stream;
  }

  List<OfferModel> offerList = [];
  List<OfferModel> categoryList = [];
  List<RestuarantModel> nearRestuarants = [];
  List<RestuarantModel> topRestuarants = [];
  OfferModel? oneOffer;

  void getOffers() async {
    isProgress = true;
    notifyListeners();
    final data = await api.offers(_errorStream);
    offerList = data ?? [];
    isProgress = false;
    notifyListeners();
  }

  void getOneOffer(int offerId) async {
    isProgress = true;
    notifyListeners();
    final data = await api.oneOffer(offerId, _errorStream);
    oneOffer = data;
    if (data != null) {}
    isProgress = false;
    notifyListeners();
  }

  void getCategories() async {
    isProgress = true;
    notifyListeners();
    final data = await api.categories(_errorStream);
    categoryList = data ?? [];
    isProgress = false;
    notifyListeners();
  }

  void getNearRestuarants(
    int region_id,
    int district_id,
    int category_id,
    int food_id,
    String keyword,
    String sort,
    int limit,
    double latitude,
    double longitude,
  ) async {
    isProgress = true;
    notifyListeners();
    final data = await api.nearRestuarants(region_id, district_id, category_id, food_id, keyword, sort, limit,
        latitude, longitude, _errorStream);
    nearRestuarants = data ?? [];
    isProgress = false;
    notifyListeners();
  }

  void getTopRestuarants(
    int region_id,
    int district_id,
    int category_id,
    int food_id,
    String keyword,
    String sort,
    int limit,
    double latitude,
    double longitude,
  ) async {
    isProgress = true;
    notifyListeners();
    final data = await api.topRestuarants(region_id, district_id, category_id, food_id, keyword, sort, limit,
        latitude, longitude, _errorStream);
    topRestuarants = data ?? [];
    isProgress = false;
    notifyListeners();
  }
}
