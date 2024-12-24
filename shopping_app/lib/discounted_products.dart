import 'package:flutter/material.dart';
import 'package:shopping_app/components/icon_cart.dart';
import 'package:shopping_app/entity/appColor.dart';
import 'package:shopping_app/entity/common_method.dart';
import 'package:shopping_app/entity/constants.dart';
import 'package:shopping_app/entity/product.dart';
import 'package:shopping_app/entity/shoppingCart.dart';
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
      appBar: myAppBar(context),
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
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '-${item.discountPercentage.toStringAsFixed(0)}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title,
                        maxLines: 2, overflow: TextOverflow.ellipsis),
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
              ),
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

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context, true);
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 30,
        ),
      ),
      centerTitle: true,
      title: Text(
        "Top Discounted Products".toUpperCase(),
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: Constants.FONT_SIZE_TITLE),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Stack(
            children: [
              IconButton(
                onPressed: () => null,
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              ),
              cart.items.length == 0 ? SizedBox.shrink() : MyIconCart(),
            ],
          ),
        ),
      ],
    );
  }
}
