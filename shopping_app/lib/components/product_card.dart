import 'package:flutter/material.dart';
import 'package:shopping_app/components/add_to_cart_button.dart';
import 'package:shopping_app/components/discount_badge.dart';
import 'package:shopping_app/components/product_details.dart';
import 'package:shopping_app/components/product_image.dart';
import 'package:shopping_app/entity/product.dart';
import 'package:shopping_app/login_page.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function(Product) onAddToCart;
  final VoidCallback onProductTap;
  final bool isLoggedIn;

  ProductCard({
    required this.product,
    required this.onAddToCart,
    required this.onProductTap,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onProductTap,
      child: Container(
        width: 150,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  ProductImage(imageUrl: product.thumbnail),
                  if (product.discountPercentage > 0)
                    DiscountBadge(discount: product.discountPercentage),
                ],
              ),
              const SizedBox(height: 8),
              ProductDetails(title: product.title, price: product.price),
              const SizedBox(height: 8),
              AddToCartButton(
                isLoggedIn: isLoggedIn,
                onLoginTap: () =>
                    Navigator.pushNamed(context, LoginPage.routeName),
                onAddToCart: () => onAddToCart(product),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
