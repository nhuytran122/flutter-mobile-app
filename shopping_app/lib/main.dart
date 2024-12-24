import 'package:flutter/material.dart';
import 'package:shopping_app/delivery_page.dart';
import 'package:shopping_app/login_page.dart';
import 'package:shopping_app/my_cart.dart';
import 'package:shopping_app/my_checkout.dart';
import 'package:shopping_app/my_shop.dart';
import 'package:shopping_app/order_history.dart';
import 'package:shopping_app/thank_you.dart';

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
        CheckOutScreen.routeName: (context) => CheckOutScreen(),
        DeliveryProgressScreen.routeName: (context) => DeliveryProgressScreen(),
        ThankYouScreen.routeName: (context) => ThankYouScreen(),
        OrderHistoryScreen.routeName: (context) => OrderHistoryScreen(),
        // MyShop.routeName: (context) => MyShop(userData: null,),
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
