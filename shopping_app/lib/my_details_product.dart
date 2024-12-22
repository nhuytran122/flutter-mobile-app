import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/components/cart_icon.dart';
import 'package:shopping_app/entity/appColor.dart';
import 'package:shopping_app/entity/common_method.dart';
import 'package:shopping_app/entity/product.dart';
import 'package:shopping_app/entity/shoppingCart.dart';
import 'package:shopping_app/my_cart.dart';
import 'package:shopping_app/my_reviews_page.dart';
import 'package:shopping_app/utils/api_service.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;
  List<Product> relatedProducts = [];

  @override
  void initState() {
    super.initState();
    fetchRelatedProducts(); // Fetch related products when the page loads
  }

  Future<void> fetchRelatedProducts() async {
    try {
      final products =
          await ApiService.getProductsByCategoryID(widget.product.category);

      if (products != null) {
        setState(() {
          relatedProducts = products;
        });
      } else {
        setState(() {
          relatedProducts = [];
        });
      }
    } catch (e) {
      print('Error fetching related products: $e');
      setState(() {
        relatedProducts = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Center(
                    child: Image.network(
                      widget.product.thumbnail,
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                  ),
                  if (widget.product.rating != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${widget.product.rating.toStringAsFixed(1)} ⭐',
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
              const SizedBox(height: 16),
              Text(widget.product.title,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '\$${widget.product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  if (widget.product.discountPercentage > 0)
                    Text(
                      '\$${CommonMethod.calculateOriginalPrice(widget.product.price, widget.product.discountPercentage).toStringAsFixed(0)}',
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Text(widget.product.description,
                  style: const TextStyle(fontSize: 14)),
              const Divider(height: 32),
              Row(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                      ),
                      Text(
                        '$quantity',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        cart.add(widget.product, quantity: quantity);
                      });
                    },
                    child: const Text("Add to Cart"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),
              const Divider(height: 32),
              buildDetailRow('Category:', widget.product.category),
              buildDetailRow('Brand:', widget.product.brand ?? 'N/A'),
              buildDetailRow('Stock:', '${widget.product.stock} items'),
              buildDetailRow('Weight:', '${widget.product.weight} kg'),
              buildDetailRow('Minimum Order Quantity:',
                  '${widget.product.minimumOrderQuantity}'),
              const Divider(height: 32),
              const Text('Reviews',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Column(
                children: widget.product.reviews
                    .take(2)
                    .map((review) => buildReviewCard(review))
                    .toList(),
              ),
              if (widget.product.reviews.length > 2)
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FullReviewPage(reviews: widget.product.reviews),
                        ),
                      );
                    },
                    child: const Text(
                      'See More Reviews',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              const Divider(height: 32),
              const Text('Related Products',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              relatedProducts.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: relatedProducts.length,
                        itemBuilder: (context, index) {
                          final relatedProduct = relatedProducts[index];
                          return buildRelatedProductCard(relatedProduct);
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget buildReviewCard(Review review) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(review.reviewerName,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 14),
                const SizedBox(width: 4),
                Text(review.rating.toString()),
              ],
            ),
            const SizedBox(height: 8),
            Text(review.comment),
          ],
        ),
      ),
    );
  }

  Widget buildRelatedProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        ).then((value) {
          if (value == true) {
            setState(() {});
          }
        });
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Image.network(product.thumbnail, height: 100, fit: BoxFit.cover),
            const SizedBox(height: 8),
            Text(
              product.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
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
        icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
      ),
      title: Text(
        widget.product.title,
        style: const TextStyle(color: Colors.white),
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, MyShoppingCart.routeName)
                    .then((value) {
                  if (value == true) {
                    setState(() {});
                  }
                });
              },
              icon: const Icon(Icons.shopping_cart, color: Colors.black),
            ),
            cart.items.length == 0 ? SizedBox.shrink() : buildCartIcon(),
          ],
        ),
      ],
    );
  }

  Widget buildCartIcon() {
    return Positioned(
      right: 5,
      top: 5,
      child: Container(
        height: 15,
        width: 15,
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '${cart.items.length}',
            style: const TextStyle(
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
