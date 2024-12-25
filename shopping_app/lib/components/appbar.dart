import 'package:flutter/material.dart';
import 'package:shopping_app/components/icon_cart.dart';
import 'package:shopping_app/entity/appColor.dart';
import 'package:shopping_app/entity/constants.dart';
import 'package:shopping_app/entity/shoppingCart.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      leading: IconButton(
        onPressed: onBackPressed,
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 30,
        ),
      ),
      centerTitle: true,
      title: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: Constants.FONT_SIZE_TITLE,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Stack(
            children: [
              IconButton(
                onPressed: () => null,
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              ),
              cart.items.isEmpty ? SizedBox.shrink() : MyIconCart(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
