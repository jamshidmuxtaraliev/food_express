import 'package:flutter/foundation.dart';
import 'package:food_express/utils/pref_utils.dart';

import '../models/offer_model.dart';
import '../models/product_model.dart';

class MainProvider with ChangeNotifier {

  List<ProductModel> _foodsByCategory = [];
  List<ProductModel> get foodsByCategory => _foodsByCategory;

  int _activeCat = PrefUtils.getActCat();
  int get activeCat=>_activeCat;

  void setActivCat(List<OfferModel> catgList, int cat_id){
    for (var element in catgList) {
      if (element.id == cat_id) {
        element.active = true;
        _activeCat = cat_id;
      }  else{
        element.active = false;
      }
    }
    notifyListeners();
  }

  List<ProductModel> getProductsByCat(List<ProductModel> products) {
    return _foodsByCategory = products.where((element) => (element.category_id == _activeCat)).toList();
    notifyListeners();
  }
}
