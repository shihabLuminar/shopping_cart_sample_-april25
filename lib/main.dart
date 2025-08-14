import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_may/controller/cart_controller.dart';
import 'package:shopping_cart_may/controller/home_screen_controller.dart';
import 'package:shopping_cart_may/controller/product_details_controller.dart';
import 'package:shopping_cart_may/controller/search_screen_controller.dart';
import 'package:shopping_cart_may/services/sql_service/sql_service.dart';
import 'package:shopping_cart_may/view/get_started_screen/get_started_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqlService.initDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductDetailsController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartController(),
        )
      ],
      child: MaterialApp(
        home: GetStartedScreen(),
      ),
    );
  }
}
