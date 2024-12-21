import 'package:flutter/material.dart';
import 'package:shopping_app/login_page.dart';
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
        // "/productlist": (context) => MyProductList(),
        // "/shoppingcart": (context) => MyShoppingCart(),
        // "/shop": (context) => MyShop(),
        // "/idol": (context) => MyIdol(),
        // "/place": (context) => MyPlace(),
        // "/homepage": (context) => MyHomepage(),
        // "/classroom": (context) => MyClassroom(),
        // "/classroom2": (context) => MyClassroom2(),
        "/myshop": (context) => MyShopOnline(),
        // "/shoppingcart2": (context) => MyShoppingCart2(),
        // "/profile": (context) => MyProfilePage(),
      },
      theme: ThemeData(
        fontFamily: "Muli",
      ),
      // home: MyShoppingCart(),
      // initialRoute: "/myshoponline",
      // home: MyShopOnline(),
      home: LoginPage(),
      // home: NewsHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
