import 'package:flutter/material.dart';
import 'package:shopping_cart_may/model/categories_model.dart';
import 'package:shopping_cart_may/model/products_res_model.dart';
import 'package:shopping_cart_may/services/api_services/api_service.dart';

class HomeScreenController with ChangeNotifier {
// state variables
  bool isCatLoading = false;
  bool isProductsLoading = false;

  List<CategroyModel> categories = []; // list of product categories
  List<Product> productsList = [];

  Future<void> getCategories() async {
    isCatLoading = true;
    notifyListeners();
    final data = await ApiServices.getData("products/categories");
    if (data != null) {
      categories = categroyModelFromJson(data);
    } else {
      print("Failed to fetch Categories");
    }

    isCatLoading = false;
    notifyListeners();
  }

// products
  Future<void> getAllProducts({String? category}) async {
    String endPoint = "products";
    if (category != null) {
      endPoint = "products/category/$category";
    }

    isProductsLoading = true;
    notifyListeners();
    final data = await ApiServices.getData(endPoint);
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
