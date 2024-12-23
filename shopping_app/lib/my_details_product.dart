import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/entity/appColor.dart';
import 'package:shopping_app/entity/common_method.dart';
import 'package:shopping_app/entity/product.dart';
import 'package:shopping_app/entity/shoppingCart.dart';
import 'package:shopping_app/my_cart.dart';
import 'package:shopping_app/my_reviews_page.dart';
import 'package:shopping_app/utils/api_service.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;

  const ProductDetailPage({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late int quantity;
  Product? product;
  List<Product> relatedProducts = [];

  @override
  void initState() {
    super.initState();
    fetchProductDetails();
  }

  Future<void> fetchProductDetails() async {
    try {
      final fetchedProduct = await ApiService.getProductByID(widget.productId);
      if (fetchedProduct != null) {
        setState(() {
          product = fetchedProduct;
          quantity = product!.minimumOrderQuantity;
        });
        fetchRelatedProducts();
      }
    } catch (e) {
      print('Error fetching product details: $e');
    }
  }

  Future<void> fetchRelatedProducts() async {
    try {
      if (product != null) {
        final products =
            await ApiService.getProductsByCategoryID(product!.category);
        setState(() {
          relatedProducts = products;
        });
      }
    } catch (e) {
      print('Error fetching related products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Product Details'),
          backgroundColor: AppColors.primary,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

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
                      product!.thumbnail,
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                  ),
                  if (product!.rating != null)
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
                          '${product!.rating.toStringAsFixed(1)} ⭐',
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
              Text(product!.title,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '\$${product!.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  if (product!.discountPercentage > 0)
                    Text(
                      '\$${CommonMethod.calculateOriginalPrice(product!.price, product!.discountPercentage).toStringAsFixed(0)}',
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Text(product!.description, style: const TextStyle(fontSize: 14)),
              const Divider(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (quantity > product!.minimumOrderQuantity) {
                                quantity--;
                              }
                            });
                          },
                          visualDensity: VisualDensity.compact,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            '$quantity',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              if (quantity < product!.stock) {
                                quantity++;
                              }
                            });
                          },
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (quantity >= product!.minimumOrderQuantity &&
                          quantity <= product!.stock) {
                        setState(() {
                          cart.add(product!, quantity: quantity);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${product!.title} added to cart (x$quantity)',
                            ),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text("Add to Cart"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      backgroundColor: AppColors.secondary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 32),
              buildDetailRow('Category:', product!.category),
              buildDetailRow('Brand:', product!.brand ?? 'N/A'),
              buildDetailRow('Stock:', '${product!.stock} items'),
              buildDetailRow('Weight:', '${product!.weight} kg'),
              buildDetailRow('Minimum Order Quantity:',
                  '${product!.minimumOrderQuantity}'),
              buildDetailRow('Warranty Information:',
                  product!.warrantyInformation ?? 'N/A'),
              buildDetailRow('Shipping Information:',
                  product!.shippingInformation ?? 'N/A'),
              buildDetailRow('Availability:', product!.availabilityStatus),
              buildDetailRow('Return Policy:', product!.returnPolicy ?? 'N/A'),
              const Divider(height: 32),
              const Text(
                'Tags:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children:
                    product!.tags.map((tag) => Chip(label: Text(tag))).toList(),
              ),
              const Divider(height: 32),
              const Text('More Images:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: product!.images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.network(
                        product!.images[index],
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),
              const Divider(height: 32),
              const Text(
                'Related Products:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              relatedProducts.isNotEmpty
                  ? SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: relatedProducts.length,
                        itemBuilder: (context, index) {
                          final relatedProduct = relatedProducts[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailPage(
                                        productId: relatedProduct.id),
                                  ),
                                );
                              },
                              child: buildRelatedProductCard(
                                  relatedProducts[index]),
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: Text('No related products available.'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRelatedProductCard(Product p) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              productId: p.id,
            ),
          ),
        ).then((value) {
          if (value == true) {
            setState(() {});
          }
        });
      },
      child: Card(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  p.thumbnail,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
                if (p.discountPercentage != null && p.discountPercentage! > 0)
                  Positioned(
                    top: 5,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${p.discountPercentage!.toStringAsFixed(0)}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              p.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              '\$${p.price}',
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  cart.add(p);
                });
              },
              child: const Text("Add to cart"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
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
        product!.title,
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

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
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
