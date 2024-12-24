import 'package:flutter/material.dart';
import 'package:shopping_app/entity/appColor.dart';
import 'package:shopping_app/my_shop.dart';
import 'package:shopping_app/utils/navigate_helper.dart';

class ThankYouScreen extends StatefulWidget {
  static String routeName = "/thank_you";

  const ThankYouScreen({Key? key}) : super(key: key);

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          "Thank You!",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: AppColors.primary,
                size: 120,
              ),
              SizedBox(height: 16),
              Text(
                "Your order has been placed successfully!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 32),
              TextButton(
                onPressed: () {
                  navigateToScreenNamed(context, MyShop.routeName, setState);
                },
                child: Text(
                  "Back to Home",
                  style: TextStyle(fontSize: 16, color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
