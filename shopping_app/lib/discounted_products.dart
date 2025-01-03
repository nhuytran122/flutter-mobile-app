import 'package:flutter/material.dart';
import 'package:shopping_app/components/appbar.dart';
import 'package:shopping_app/components/discount_badge.dart';
import 'package:shopping_app/entity/common_method.dart';
import 'package:shopping_app/entity/product.dart';
import 'package:shopping_app/my_details_product.dart';
import 'package:shopping_app/utils/navigate_helper.dart';

class DiscountedProductsScreen extends StatefulWidget {
  static String routeName = '/discounted_products';
  final List<Product> discountedProducts;

  DiscountedProductsScreen({required this.discountedProducts});

  @override
  State<DiscountedProductsScreen> createState() =>
      _DiscountedProductsScreenState();
}

class _DiscountedProductsScreenState extends State<DiscountedProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "Top Discounted Products"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: widget.discountedProducts.length,
          itemBuilder: (context, index) {
            final product = widget.discountedProducts[index];
            return _buildCartItem(product);
          },
        ),
      ),
    );
  }

  Widget _buildCartItem(Product item) {
    return GestureDetector(
        onTap: () {
          navigateToScreenWithPara(
              context, ProductDetailPage(productId: item.id), setState);
        },
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(item.thumbnail),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  if (item.discountPercentage > 0)
                    DiscountBadge(discount: item.discountPercentage),
                ],
              ),
              const SizedBox(width: 12),
              _buildDetailInfProduct(item),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text(
                  'x${item.stock}',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ));
  }

  Expanded _buildDetailInfProduct(Product item) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.title, maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                CommonMethod.formatPrice(item.price),
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                CommonMethod.formatPrice(
                  CommonMethod.calculateOriginalPrice(
                      item.price, item.discountPercentage),
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
    );
  }

  CustomAppBar myAppBar(BuildContext context, String title) {
    return CustomAppBar(
      title: title,
      onBackPressed: () {
        Navigator.pop(context, true);
      },
    );
  }
}
