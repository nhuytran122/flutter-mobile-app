import 'package:flutter_g8/my_classroom.dart';
import 'package:flutter_g8/my_classroom2.dart';
import 'package:flutter_g8/my_homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_g8/my_idol.dart';
import 'package:flutter_g8/my_list_prd_category.dart';
import 'package:flutter_g8/my_place.dart';
import 'package:flutter_g8/my_productlist.dart';
import 'package:flutter_g8/my_shop.dart';
import 'package:flutter_g8/my_shop_online.dart';
import 'package:flutter_g8/my_shoppingcart.dart';
import 'package:flutter_g8/my_shoppingcart2.dart';

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
        "/idol": (context) => MyIdol(),
        "/place": (context) => MyPlace(),
        "/homepage": (context) => MyHomepage(),
        "/classroom": (context) => MyClassroom(),
        "/classroom2": (context) => MyClassroom2(),
        "/myshoponline": (context) => MyShopOnline(),
        "/shoppingcart2": (context) => MyShoppingCart2(),
        // "/listproductsflcate":(context) => MyListPrdCategory(category: category, allProducts: allProducts)
      },
      // home: MyShoppingCart(),
      initialRoute: "/myshoponline",
      home: MyShopOnline(),
      debugShowCheckedModeBanner: false,
    );
  }
}
