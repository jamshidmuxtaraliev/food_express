import 'package:flutter/foundation.dart';
import 'package:food_express/utils/pref_utils.dart';

import '../models/cart_model.dart';
import '../models/offer_model.dart';
import '../models/product_model.dart';

class MainProvider with ChangeNotifier {
  List<ProductModel> _foodsByCategory = [];

  List<ProductModel> get foodsByCategory => _foodsByCategory;

  int _activeCat = PrefUtils.getActCat();

  int get activeCat => _activeCat;

  void clearCart(){
    PrefUtils.setCartList([]);
    notifyListeners();
  }

  int getCartCount(int id){
    var cartList = PrefUtils.getCartList();
    return  cartList.where((element) => element.id == id).firstOrNull?.cart_count??0;
  }

  Future<void> addToCart(CartModel cartModel) async {
    var cartList = PrefUtils.getCartList();

    if (cartModel.cart_count == 0) {
      var index = 0;
      var removeIndex = -1;
      for (var element in cartList) {
        if (element.id == cartModel.id) {
          removeIndex = index;
        }
        index++;
      }
      removeIndex > -1;
      cartList.removeAt(removeIndex);
    } else {
      var haveInCart = false;
      for (var item in cartList) {
        if (item.id == cartModel.id) {
          item.cart_count = cartModel.cart_count;
          item.initialPrice = cartModel.initialPrice;
          haveInCart = true;
        }
      }

      if (!haveInCart) {
        cartList.add(cartModel);
      }
    }

    await PrefUtils.setCartList(cartList);
    notifyListeners();
  }

  void setActivCat(List<OfferModel> catgList, int cat_id) {
    for (var element in catgList) {
      if (element.id == cat_id) {
        element.active = true;
        _activeCat = cat_id;
      } else {
        element.active = false;
      }
    }
    notifyListeners();
  }

  List<ProductModel> getProductsByCat(List<ProductModel> products) {
    return _foodsByCategory = products.where((element) => (element.category_id == _activeCat)).toList();
    notifyListeners();
  }

  bool _resetPasword = true;
  bool get rePasScreen => _resetPasword;

  bool _updateProfile = true;
  bool get updtScreen => _updateProfile;

  void resetPaswordScreen(bool value){
    _resetPasword = value;
    notifyListeners();
  }

  void updateScreen(bool value){
    _updateProfile = value;
    notifyListeners();
  }
}
