import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/components/product_card.dart';
import 'package:shopping_app/components/search_appbar.dart';
import 'package:shopping_app/entity/product.dart';
import 'package:shopping_app/entity/shoppingCart.dart';
import 'package:shopping_app/my_cart.dart';
import 'package:shopping_app/my_details_product.dart';
import 'package:shopping_app/utils/api_service.dart';
import 'package:shopping_app/utils/navigate_helper.dart';
import 'package:shopping_app/utils/user_provider.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String category;

  const CategoryProductsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  late Future<List<Product>> futureProducts;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    futureProducts = ApiService.getProductsByCategoryID(widget.category);
  }

  Future<List<Product>> searchProducts(String query) async {
    final allProducts =
        await ApiService.getProductsByCategoryID(widget.category);
    return allProducts.where((product) {
      return product.title.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSearchWithCateAppBar(
          context, 'Search products in ${widget.category} category'),
      body: FutureBuilder<List<Product>>(
        future:
            searchQuery.isEmpty ? futureProducts : searchProducts(searchQuery),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No products found in this category."),
            );
          }

          final products = snapshot.data!;
          return buildProductList(products);
        },
      ),
    );
  }

  Widget buildProductList(List<Product> products) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return buildProductCard(products[index]);
      },
    );
  }

  ProductCard buildProductCard(Product product) {
    final userData = Provider.of<UserProvider>(context, listen: false).userData;
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

  CustomSearchAppBar buildSearchWithCateAppBar(
      BuildContext context, String hintTextTitle) {
    return CustomSearchAppBar(
      hintText: hintTextTitle,
      onBackPressed: () {
        Navigator.pop(context, true);
      },
      onCartPressed: () {
        navigateToScreenNamed(
          context,
          MyShoppingCart.routeName,
          setState,
        );
      },
      searchQuery: searchQuery,
      onSearchChanged: (value) {
        setState(() {
          searchQuery = value;
        });
      },
    );
  }
}
