import 'package:flutter/material.dart';
import 'package:shopping_cart_may/model/categories_model.dart';
import 'package:shopping_cart_may/services/api_services/api_service.dart';

class HomeScreenController with ChangeNotifier {
// state variables
  bool isCatLoading = false;
  List<CategroyModel> categories = [];

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

  void getAllProducts() {}
}
