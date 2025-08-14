import 'package:flutter/material.dart';
import 'package:shopping_cart_may/model/product_details_model.dart';
import 'package:shopping_cart_may/model/products_res_model.dart';
import 'package:shopping_cart_may/services/sql_service/sql_service.dart';

class CartController with ChangeNotifier {
  List<Map> cartItems = [];
  Future<void> getCartItems() async {
    cartItems = await SqlService.getData();
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

  void incrementQty() {}
  void decrementQty() {}
  void deleteProduct() {}
}
