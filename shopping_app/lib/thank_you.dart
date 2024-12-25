import 'package:flutter/material.dart';
import 'package:shopping_app/entity/appColor.dart';
import 'package:shopping_app/entity/order.dart';
import 'package:shopping_app/my_shop.dart';
import 'package:shopping_app/order_detail.dart';
import 'package:shopping_app/utils/navigate_helper.dart';

class ThankYouScreen extends StatefulWidget {
  final Order order;

  const ThankYouScreen({Key? key, required this.order}) : super(key: key);

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
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.check_circle,
              color: AppColors.primary,
              size: 120,
            ),
            SizedBox(height: 16),
            Text(
              "Order Placed Successfully!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Thank you for shopping with us. You can track your order or continue browsing for more amazing products.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 32),
            _buildButtonViewDetailsOrder(context),
            SizedBox(height: 16),
            _buildButtonBackHome(context),
          ],
        ),
      ),
    );
  }

  ElevatedButton _buildButtonViewDetailsOrder(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        navigateToScreenWithPara(
          context,
          OrderDetailScreen(order: widget.order),
          setState,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          "View Order",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  OutlinedButton _buildButtonBackHome(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        navigateToScreenNamed(context, MyShop.routeName, setState);
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColors.primary, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          "Back to Home",
          style: TextStyle(fontSize: 16, color: AppColors.primary),
        ),
      ),
    );
  }
}
