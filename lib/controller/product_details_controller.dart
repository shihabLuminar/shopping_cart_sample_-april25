import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shopping_cart_may/model/product_details_model.dart';
import 'package:shopping_cart_may/model/products_res_model.dart';
import 'package:shopping_cart_may/services/api_services/api_service.dart';

class ProductDetailsController with ChangeNotifier {
  bool isLoading = false;
  ProductDetailsResModel? productDetails;

  Future<void> getProductDetails({required String pdId}) async {
    isLoading = true;
    notifyListeners();
    final data = await ApiServices.getData("products/$pdId");
    if (data != null) {
      log(data);
      productDetails = productDetailsResModelFromJson(data);
    } else {
      print("Failed to fetch Categories");
    }

    isLoading = false;
    notifyListeners();
  }
}
