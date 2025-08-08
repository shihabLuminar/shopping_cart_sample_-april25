import 'package:http/http.dart' as http;
import 'package:shopping_cart_may/app_config/app_config.dart';

class ApiServices {
  static Future<String?> getData(String enpointUrl) async {
    final url = Uri.parse("${AppConfig.baseUrl}$enpointUrl");
    final response = await http.get(url);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body;
    }
  }

  void postData() {}
  void putData() {}
  void patchData() {}
  void deleteData() {}
}
