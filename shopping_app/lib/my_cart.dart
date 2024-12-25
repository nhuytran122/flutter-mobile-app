import 'package:flutter/material.dart';
import 'package:shopping_app/components/appbar.dart';
import 'package:shopping_app/entity/common_method.dart';
import 'package:shopping_app/entity/shoppingCart.dart';
import 'package:shopping_app/my_checkout.dart';
import 'package:shopping_app/my_details_product.dart';
import 'package:shopping_app/utils/navigate_helper.dart';

class MyShoppingCart extends StatefulWidget {
  static String routeName = "/cart";
  const MyShoppingCart({super.key});

  @override
  State<MyShoppingCart> createState() => _MyShoppingCartState();
}

class _MyShoppingCartState extends State<MyShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: myAppBar(context, 'My Cart'),
      body: Column(
        children: [
          cart.items.isNotEmpty ? _buildShoppingCart() : _buildEmptyCart(),
          if (cart.items.isNotEmpty) _buildBottom(),
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return const Expanded(
      child: Center(
        child: Text(
          "YOUR CART IS EMPTY",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildShoppingCart() {
    return Expanded(
      child: ListView(
        children: [
          ...cart.items.map((e) => _buildProductSection(e)).toList(),
        ],
      ),
    );
  }

  Widget _buildProductSection(ItemInCart it) {
    return GestureDetector(
      onTap: () {
        navigateToScreenWithPara(
            context, ProductDetailPage(productId: it.product.id), setState);
      },
      child: Dismissible(
        key:
            Key(it.product.id.toString()), // Đảm bảo mỗi item có key riêng biệt
        direction: DismissDirection.endToStart, // Chỉ vuốt từ phải qua trái
        onDismissed: (direction) {
          setState(() {
            cart.remove(it.product);
          });
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          child: const Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
        child: _buildDetailsItemInCart(it),
      ),
    );
  }

  Card _buildDetailsItemInCart(ItemInCart it) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(it.product.thumbnail),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: buildSectionShowPrice(it),
                ),
                _buildButtonEditQuantity(it),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column buildSectionShowPrice(ItemInCart it) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          it.product.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              '${CommonMethod.formatPrice(it.product.price)}',
              style: const TextStyle(
                color: Color(0xFFEE4D2D),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '${CommonMethod.formatPrice(CommonMethod.calculateOriginalPrice(it.product.price, it.product.discountPercentage))}',
              style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container _buildButtonEditQuantity(ItemInCart it) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                cart.addItemInCart(it.product, quantity: -1);
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.remove, size: 16),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '${it.quantity}',
              style: const TextStyle(fontSize: 14),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                if (it.quantity < it.product.stock) {
                  cart.addItemInCart(it.product, quantity: 1);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Cannot add more than available stock!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.add, size: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Total:',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              Text(
                '${CommonMethod.formatPrice(cart.getTotal())}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          _buildButtonCheckout(),
        ],
      ),
    );
  }

  ElevatedButton _buildButtonCheckout() {
    return ElevatedButton(
      onPressed: () {
        navigateToScreenNamed(
          context,
          CheckOutScreen.routeName,
          setState,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE86343),
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Text(
        'Check Out',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
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
