import 'package:flutter/material.dart';
import 'package:shopping_cart_may/model/products_res_model.dart';
import 'package:shopping_cart_may/services/api_services/api_service.dart';

class SearchScreenController with ChangeNotifier {
  // https://dummyjson.com/products/search?q=phone
  bool isProductsLoading = false;

  List<Product> productsList = [];

  Future<void> searchProducts({String? query}) async {
    isProductsLoading = true;
    notifyListeners();
    final data = await ApiServices.getData("products/search?q=$query");
    if (data != null) {
      ProductsResModel resModel = productsResModelFromJson(data);

      productsList = resModel.products ?? [];
    } else {
      print("Failed to fetch Categories");
    }

    isProductsLoading = false;
    notifyListeners();
  }
}
