import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/components/appbar.dart';
import 'package:shopping_app/components/product_card.dart';
import 'package:shopping_app/entity/appColor.dart';
import 'package:shopping_app/entity/common_method.dart';
import 'package:shopping_app/entity/product.dart';
import 'package:shopping_app/entity/shoppingCart.dart';
import 'package:shopping_app/entity/user.dart';
import 'package:shopping_app/filter_products_by_category.dart';
import 'package:shopping_app/login_page.dart';
import 'package:shopping_app/my_reviews_page.dart';
import 'package:shopping_app/utils/api_service.dart';
import 'package:shopping_app/utils/navigate_helper.dart';
import 'package:shopping_app/utils/user_provider.dart';

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
  int quantity = 1;
  Product? product;
  List<Product> relatedProducts = [];
  late User? userData;

  @override
  void initState() {
    super.initState();
    fetchProductDetails();
    userData = Provider.of<UserProvider>(context, listen: false).userData;
  }

  Future<void> fetchProductDetails() async {
    try {
      final fetchedProduct = await ApiService.getProductByID(widget.productId);
      if (fetchedProduct != null) {
        setState(() {
          product = fetchedProduct;
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
      appBar: myAppBar(context, product!.title),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImgWithRate(),
              const SizedBox(height: 16),
              Text(product!.title,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildSectionPrice(),
              const SizedBox(height: 16),
              Text(product!.description, style: const TextStyle(fontSize: 14)),
              const Divider(height: 32),
              _buildActionAddToCart(context),
              const Divider(height: 32),
              _buildShowCategory(context),
              _buildDetailRow('Brand:', product!.brand ?? 'N/A'),
              _buildDetailRow('Stock:', '${product!.stock} items'),
              _buildDetailRow('Weight:', '${product!.weight} kg'),
              _buildDetailRow(
                  'Warranty Information:', product!.warrantyInformation),
              _buildDetailRow(
                  'Shipping Information:', product!.shippingInformation),
              _buildDetailRow('Availability:', product!.availabilityStatus),
              _buildDetailRow('Return Policy:', product!.returnPolicy),
              const Divider(height: 32),
              _buildSubTitle("Tags: "),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children:
                    product!.tags.map((tag) => Chip(label: Text(tag))).toList(),
              ),
              const Divider(height: 32),
              _buildSubTitle("More Images:"),
              const SizedBox(height: 8),
              _buildShowMoreImg(),
              const Divider(height: 32),
              _buildSubTitle("Reviews:"),
              const SizedBox(height: 8),
              Column(
                children: product!.reviews
                    .take(2)
                    .map((review) => _buildReviewCard(review))
                    .toList(),
              ),
              if (product!.reviews.length > 2)
                Center(
                  child: TextButton(
                    onPressed: () {
                      navigateToScreenWithPara(context,
                          FullReviewPage(reviews: product!.reviews), setState);
                    },
                    child: const Text(
                      'See More Reviews',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              _buildSubTitle("Related Products:"),
              const SizedBox(height: 8),
              relatedProducts.isNotEmpty
                  ? SizedBox(
                      height: 220,
                      child: _buildRelatedProducts(),
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

  GestureDetector _buildShowCategory(BuildContext context) {
    return GestureDetector(
        onTap: () {
          navigateToScreenWithPara(context,
              CategoryProductsScreen(category: product!.category), setState);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Category:',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                product!.category,
                style: TextStyle(
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),
        ));
  }

  SizedBox _buildShowMoreImg() {
    return SizedBox(
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
    );
  }

  Stack _buildImgWithRate() {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Center(
          child: Image.network(
            product!.thumbnail,
            height: 250,
            fit: BoxFit.contain,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${product!.rating}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _buildActionAddToCart(BuildContext context) {
    return Row(
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
                    if (quantity > 1) {
                      quantity--;
                    }
                  });
                },
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
                  final currentQuantityInCart =
                      cart.getQuantityItemInCart(product!.id);
                  final totalQuantityToAdd = currentQuantityInCart + quantity;

                  setState(() {
                    if (totalQuantityToAdd < product!.stock) {
                      quantity++;
                    } else {
                      // Hiển thị thông báo nếu tổng số lượng vượt quá tồn kho
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Only ${product!.stock - currentQuantityInCart} more items are available in stock!',
                          ),
                        ),
                      );
                    }
                  });
                },
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ),
        _buildButtonAddToCart(),
      ],
    );
  }

  ElevatedButton _buildButtonAddToCart() {
    return ElevatedButton.icon(
      onPressed: () {
        if (userData == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Please log in to add items to the cart.'),
              action: SnackBarAction(
                label: 'Log in',
                onPressed: () {
                  navigateToScreenNamed(context, LoginPage.routeName, setState);
                },
              ),
            ),
          );
        } else {
          setState(() {
            cart.add(product!, quantity: quantity);
          });
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
    );
  }

  Row _buildSectionPrice() {
    return Row(
      children: [
        Text(
          '${CommonMethod.formatPrice(product!.price)}',
          style: const TextStyle(
              fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        if (product!.discountPercentage > 0)
          Text(
            '${CommonMethod.formatPrice(CommonMethod.calculateOriginalPrice(product!.price, product!.discountPercentage))}',
            style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough),
          ),
      ],
    );
  }

  ListView _buildRelatedProducts() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: relatedProducts.length,
      itemBuilder: (context, index) {
        final relatedProduct = relatedProducts[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () {
              navigateToScreenWithPara(context,
                  ProductDetailPage(productId: relatedProduct.id), setState);
            },
            child: buildRelatedProductCard(relatedProducts[index]),
          ),
        );
      },
    );
  }

  Widget _buildSubTitle(String subTitle) {
    return Text(
      subTitle,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  ProductCard buildRelatedProductCard(Product product) {
    return ProductCard(
      product: product,
      onAddToCart: (product) {
        setState(() {
          cart.add(product, quantity: 1);
        });
      },
      onProductTap: () {
        navigateToScreenWithPara(
            context, ProductDetailPage(productId: product.id), setState);
      },
      isLoggedIn: userData != null,
    );
  }

  Widget _buildDetailRow(String title, String value) {
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

  Widget _buildReviewCard(Review review) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              review.reviewerName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
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

  CustomAppBar myAppBar(BuildContext context, String title) {
    return CustomAppBar(
      title: title,
      onBackPressed: () {
        Navigator.pop(context, true);
      },
    );
  }
}
