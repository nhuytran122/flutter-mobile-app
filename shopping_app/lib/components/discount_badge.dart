import 'package:flutter/material.dart';

class DiscountBadge extends StatelessWidget {
  final double discount;

  const DiscountBadge({required this.discount});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 5,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          '${discount.toStringAsFixed(0)}%',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
