import 'package:flutter/material.dart';
import 'package:shopping_app/entity/appColor.dart';
import 'package:shopping_app/entity/common_method.dart';
import 'package:shopping_app/entity/constants.dart';
import 'package:shopping_app/entity/shoppingCart.dart';
import 'package:shopping_app/my_checkout.dart';

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
      appBar: myAppBar(context),
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
          ...cart.items.map((e) => _buildShopSection(e)).toList(),
        ],
      ),
    );
  }

  Widget _buildShopSection(ItemInCart it) {
    return Dismissible(
      key: Key(it.id.toString()), // Đảm bảo mỗi item có key riêng biệt
      direction: DismissDirection.endToStart, // Chỉ vuốt từ phải qua trái
      onDismissed: (direction) {
        setState(() {
          // Giảm tổng giá trị khi item bị xóa
          cart.remove(it);
        });
      },
      background: Container(
        color: Colors.red, // Màu nền khi vuốt
        alignment: Alignment.centerRight,
        child: const Padding(
          padding: EdgeInsets.only(right: 20),
          child: Icon(Icons.delete, color: Colors.white), // Biểu tượng xóa
        ),
      ),
      child: Card(
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
                        image: NetworkImage(it.thumbnail),
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
                          it.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '\$${it.price.toStringAsFixed(0)}',
                              style: const TextStyle(
                                color: Color(0xFFEE4D2D),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '\$${(CommonMethod.calculateOriginalPrice(it.price, it.discountPercentage)).toStringAsFixed(0)}',
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
                  Container(
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
                              cart.addItemInCart(it, quantity: -1);
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
                              cart.addItemInCart(it, quantity: 1);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: const Icon(Icons.add, size: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                '\$${cart.getTotal().toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, CheckOutScreen.routeName)
                  .then((value) {
                if (value == true) {
                  setState(() {}); // Cập nhật khi quay về
                }
              });
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
          ),
        ],
      ),
    );
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
      title: Center(
        child: Text(
          "Your Cart".toUpperCase(),
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: Constants.FONT_SIZE_TITLE),
        ),
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
              cart.items.length == 0 ? SizedBox.shrink() : myIconCart(),
            ],
          ),
        ),
      ],
    );
  }

  Positioned myIconCart() {
    return Positioned(
      right: 5,
      top: 5,
      child: Container(
        height: 15,
        width: 15,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '${cart.items.length}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
