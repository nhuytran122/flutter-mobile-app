import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/login_page.dart';
import 'package:shopping_app/my_cart.dart';
import 'package:shopping_app/my_checkout.dart';
import 'package:shopping_app/my_profile.dart';
import 'package:shopping_app/my_shop.dart';
import 'package:shopping_app/order_history.dart';
import 'package:shopping_app/utils/user_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        routes: {
          LoginPage.routeName: (context) => LoginPage(),
          MyShoppingCart.routeName: (context) => MyShoppingCart(),
          CheckOutScreen.routeName: (context) => CheckOutScreen(),
          OrderHistoryScreen.routeName: (context) => OrderHistoryScreen(),
          MyShop.routeName: (context) => MyShop(),
          MyProfileScreen.routeName: (context) => MyProfileScreen(),
        },
        theme: ThemeData(
          fontFamily: "Muli",
        ),
        initialRoute: LoginPage.routeName,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
