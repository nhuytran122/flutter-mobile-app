import 'package:flutter_g8/my_classroom.dart';
import 'package:flutter_g8/my_classroom2.dart';
import 'package:flutter_g8/my_homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_g8/my_idol.dart';
import 'package:flutter_g8/my_place.dart';
import 'package:flutter_g8/my_productlist.dart';
import 'package:flutter_g8/my_shop.dart';
import 'package:flutter_g8/my_shoppingcart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/productlist": (context) => MyProductList(),
        "/shoppingcart": (context) => MyShoppingCart(),
        "/shop": (context) => MyShop(),
      },
      // home: MyShoppingCart(),
      initialRoute: "/shop",
      home: MyClassroom2(),
      debugShowCheckedModeBanner: false,
    );
  }
}
