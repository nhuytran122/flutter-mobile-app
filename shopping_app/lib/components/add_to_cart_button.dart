import 'package:flutter/material.dart';
import 'package:shopping_app/entity/appColor.dart';

class AddToCartButton extends StatelessWidget {
  final bool isLoggedIn;
  final VoidCallback onLoginTap;
  final VoidCallback onAddToCart;

  const AddToCartButton({
    required this.isLoggedIn,
    required this.onLoginTap,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoggedIn
          ? onAddToCart
          : () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      const Text('Please log in to add items to the cart.'),
                  action: SnackBarAction(
                    label: 'Log in',
                    onPressed: onLoginTap,
                  ),
                ),
              );
            },
      child: const Text("Add to cart"),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
      ),
    );
  }
}
