import 'package:flutter/material.dart';
import 'package:shopping_app/entity/common_method.dart';
import 'package:shopping_app/entity/shoppingCart.dart';

class CartItemCard extends StatelessWidget {
  final ItemInCart item;
  final Function(BuildContext context) navigateToProductDetail;

  const CartItemCard({
    Key? key,
    required this.item,
    required this.navigateToProductDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToProductDetail(context),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(item.product.thumbnail),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        CommonMethod.formatPrice(item.product.price),
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        CommonMethod.formatPrice(
                          CommonMethod.calculateOriginalPrice(
                            item.product.price,
                            item.product.discountPercentage,
                          ),
                        ),
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Text(
                'x${item.quantity}',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
