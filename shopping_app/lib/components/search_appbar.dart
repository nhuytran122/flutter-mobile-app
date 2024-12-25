import 'package:flutter/material.dart';
import 'package:shopping_app/components/icon_cart.dart';
import 'package:shopping_app/entity/appColor.dart';
import 'package:shopping_app/entity/shoppingCart.dart';

class CustomSearchAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String hintText;
  final VoidCallback onBackPressed;
  final VoidCallback onCartPressed;
  final String searchQuery;
  final Function(String) onSearchChanged;

  const CustomSearchAppBar({
    Key? key,
    required this.hintText,
    required this.onBackPressed,
    required this.onCartPressed,
    required this.searchQuery,
    required this.onSearchChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      leading: IconButton(
        onPressed: onBackPressed,
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 30,
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Colors.white),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
            ),
          ),
        ],
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: onCartPressed,
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            cart.items.isEmpty ? const SizedBox.shrink() : MyIconCart(),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
