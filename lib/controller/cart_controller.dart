import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shopping_cart_may/model/product_details_model.dart';
import 'package:shopping_cart_may/services/sql_service/sql_service.dart';

class CartController with ChangeNotifier {
  List<Map> cartItems = [];
  double totalPrice = 0.00;

  void calTotal() {
    totalPrice = 0.00;
    for (var item in cartItems) {
      totalPrice += item["qty"] * item['price'];
      log(totalPrice.toString() + "-----------------> total price");
    }
  }

  Future<void> getCartItems() async {
    cartItems = await SqlService.getData();
    calTotal();
    notifyListeners();
  }

  Future<void> addTocart(
      BuildContext context, ProductDetailsResModel product) async {
    try {
      await SqlService.addData({
        "id": product.id,
        "title": product.title,
        "qty": 1,
        "price": product.price,
        "img": product.thumbnail,
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Item already in the cart ")));
      print(e.toString());
    }
    await getCartItems();
  }

  Future<void> incrementQty(
      {required int pdId, required int currentQty}) async {
    await SqlService.editData(qty: currentQty + 1, productId: pdId);
    await getCartItems();
  }

  Future<void> decrementQty(
      {required int pdId, required int currentQty}) async {
    if (currentQty > 1) {
      await SqlService.editData(qty: currentQty - 1, productId: pdId);
      await getCartItems();
    }
  }

  Future<void> deleteProduct({
    required int pdId,
  }) async {
    await SqlService.deleteData(pdId);
    await getCartItems();
  }

  Future<void> clearCart() async {
    await SqlService.clearCart();
    await getCartItems();
  }
}
