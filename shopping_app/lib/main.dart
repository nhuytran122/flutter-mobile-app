import 'package:flutter/material.dart';
import 'package:shopping_app/login_page.dart';
import 'package:shopping_app/my_cart.dart';
import 'package:shopping_app/my_shop.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        MyShoppingCart.routeName: (context) => MyShoppingCart(),
      },
      theme: ThemeData(
        fontFamily: "Muli",
      ),
      initialRoute: LoginPage.routeName,
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
