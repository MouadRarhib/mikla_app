import 'dart:convert';

import 'package:mikla_project/models/cart_model.dart';
import 'package:mikla_project/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  late final SharedPreferences sharedPreferences; // we save the cart data here
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];
  void addToCartList(List<CartModel> cartList) {
    sharedPreferences.remove(AppConstants.CART_LIST);
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    // we want to send this list in the sharedPreferences but its a object not String
    var time = DateTime.now().toString();
    cart = [];
    // we change the cartList to string

    // we add the cartList into the cart[]

    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(
        AppConstants.CART_LIST, cart); // add cart into the sharedpreferences
    // print(sharedPreferences.getStringList(AppConstants.CART_LIST))
    //getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      // print("inside getCartList " + carts.toString());
    }
    List<CartModel> cartList = [];

    /*carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });*/ // we remove this because is the same thins here in the next line=>

    carts.forEach(
        (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) =>
        cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < cart.length; i++) {
      // print("history list " + cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);
    //print("The lenght of history list is " +
    //  getCartHistoryList().length.toString());
    for (int i = 0; i < getCartHistoryList().length; i++) {
      //print("The time of the order is  " +
      //  getCartHistoryList()[i].time.toString());
    }
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  void clearCartHistory() {
    removeCart();
    cartHistory = [];
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }
}
