import 'package:flutter/material.dart';
import 'package:shopping_app/entity/appColor.dart';

class TitleWithSeeMore extends StatelessWidget {
  final String title;
  final bool seeMore;
  final VoidCallback? onSeeMorePressed;

  const TitleWithSeeMore({
    Key? key,
    required this.title,
    required this.seeMore,
    this.onSeeMorePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (seeMore)
            GestureDetector(
              onTap: onSeeMorePressed ?? () {},
              child: const Text(
                "See more",
                style: TextStyle(
                  color: AppColors.secondary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
