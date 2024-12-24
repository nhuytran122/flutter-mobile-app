import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/components/category_card.dart';
import 'package:shopping_app/components/drawer.dart';
import 'package:shopping_app/components/icon_cart.dart';
import 'package:shopping_app/components/product_card.dart';
import 'package:shopping_app/components/tag_chip.dart';
import 'package:shopping_app/components/title_with_seemore.dart';
import 'package:shopping_app/discounted_products.dart';

import 'package:shopping_app/entity/appColor.dart';
import 'package:shopping_app/entity/category.dart';
import 'package:shopping_app/entity/order.dart';
import 'package:shopping_app/entity/product.dart';
import 'package:shopping_app/entity/shoppingCart.dart';
import 'package:shopping_app/entity/user.dart';
import 'package:shopping_app/filter_products_by_category.dart';
import 'package:shopping_app/login_page.dart';
import 'package:shopping_app/my_cart.dart';
import 'package:shopping_app/my_details_product.dart';
import 'package:shopping_app/my_profile.dart';
import 'package:shopping_app/order_history.dart';
import 'package:shopping_app/utils/api_service.dart';
import 'package:shopping_app/utils/navigate_helper.dart';
import 'package:shopping_app/utils/user_provider.dart';

class MyShop extends StatefulWidget {
  static String routeName = "/home";

  const MyShop({Key? key}) : super(key: key);

  @override
  State<MyShop> createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  late List<Product> allProducts = [];
  List<Product> filteredProducts = [];
  bool noResultsFound = false;
  List<String> selectedTags = [];
  List<Product> discountedProducts = [];
  String searchQuery = "";
  late User? userData;
  int _selectedIndex = 0;

  late Future<List<Product>> lsProduct;
  late Future<List<Category>> lsCategories;

  @override
  void initState() {
    super.initState();
    lsProduct = ApiService.getAllProducts();
    lsCategories = ApiService.getAllCategories();
    userData = Provider.of<UserProvider>(context, listen: false).userData;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getBodyContent() {
    switch (_selectedIndex) {
      case 0:
        return buildHomePage();
      case 1:
        return OrderHistoryScreen();
      case 2:
        return MyProfileScreen();
      default:
        return buildHomePage();
    }
  }

  Widget buildHomePage() {
    return FutureBuilder<List<Product>>(
      future: lsProduct,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No products found."));
        } else {
          allProducts = snapshot.data!;
          if (filteredProducts.isEmpty && !noResultsFound) {
            filteredProducts = allProducts;
          }
          List<String> listTags = getListTags(allProducts);

          return ListView(
            children: [
              FutureBuilder<List<Category>>(
                future: lsCategories,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No categories found."));
                  } else {
                    return _buildCategories(snapshot.data!);
                  }
                },
              ),
              _buildTags(listTags),
              TitleWithSeeMore(
                title: "Top Sales",
                seeMore: true,
                onSeeMorePressed: () {
                  navigateToScreenWithPara(
                      context,
                      DiscountedProductsScreen(
                          discountedProducts: discountedProducts),
                      setState);
                },
              ),
              _buildTopSales(getTopSaleProducts(allProducts).take(5).toList()),
              TitleWithSeeMore(
                title: "All Products",
                seeMore: false,
                onSeeMorePressed: null,
              ),
              noResultsFound
                  ? _buildNoResultsMessage()
                  : _buildProductList(filteredProducts),
            ],
          );
        }
      },
    );
  }

  List<String> getListTags(List<Product> products) {
    final tags = <String>{};
    for (var product in products) {
      tags.addAll(product.tags);
    }
    return tags.toList();
  }

  List<Product> getTopSaleProducts(List<Product> products) {
    discountedProducts =
        products.where((product) => product.discountPercentage > 0).toList();
    discountedProducts
        .sort((a, b) => b.discountPercentage.compareTo(a.discountPercentage));
    return discountedProducts.take(10).toList();
  }

  void filterProducts() {
    setState(() {
      filteredProducts = allProducts.where((product) {
        final matchesTags = selectedTags.isEmpty ||
            (product.tags.any((tag) => selectedTags.contains(tag)));
        final matchesQuery = searchQuery.isEmpty ||
            product.title.toLowerCase().contains(searchQuery.toLowerCase());
        return matchesTags && matchesQuery;
      }).toList();

      noResultsFound = filteredProducts.isEmpty &&
          (searchQuery.isNotEmpty || selectedTags.isNotEmpty);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      appBar: _myAppBar(context),
      body: _getBodyContent(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  MyDrawer _buildDrawer() {
    return MyDrawer(
      userData: userData,
      onIndexSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: "Orders History (${listOrders.orders.length})",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "My Profile",
        ),
      ],
    );
  }

  Widget _buildCategories(List<Category> listCategories) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: listCategories.map((category) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                navigateToScreenWithPara(context,
                    CategoryProductsScreen(category: category.slug), setState);
              },
              child: CategoryCard(icon: Icons.category, label: category.name),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTags(List<String> listTags) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(bottom: 16),
        child: Row(
          children: listTags.map((tag) {
            final isSelected = selectedTags.contains(tag);
            return TagChip(
              tag: tag,
              isSelected: isSelected,
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    selectedTags.add(tag);
                  } else {
                    selectedTags.remove(tag);
                  }
                  filterProducts();
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTopSales(List<Product> lstTopSales) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: lstTopSales.map((product) {
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                width: 150,
                child: _buildProductCard(product),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  ProductCard _buildProductCard(Product product) {
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

  Widget _buildProductList(List<Product> products) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductCard(products[index]);
      },
    );
  }

  AppBar _myAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      title: Row(
        children: [
          Expanded(
            child: _buildSearchTextField(),
          ),
        ],
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () {
                navigateToScreenNamed(
                  context,
                  MyShoppingCart.routeName,
                  setState,
                );
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
            ),
            cart.items.length == 0 ? SizedBox.shrink() : MyIconCart(),
          ],
        ),
      ],
    );
  }

  TextField _buildSearchTextField() {
    return TextField(
      onTap: () {
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
        }
      },
      onChanged: (value) {
        setState(() {
          searchQuery = value;
          if (_selectedIndex == 0) {
            filterProducts(); // Chỉ tìm kiếm nếu đang ở trang Home
          }
        });
      },
      decoration: const InputDecoration(
        hintText: 'Search Products...',
        hintStyle: TextStyle(color: Colors.white70),
        border: InputBorder.none,
        prefixIcon: Icon(Icons.search, color: Colors.white),
        contentPadding: EdgeInsets.symmetric(vertical: 12),
      ),
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
    );
  }

  Widget _buildNoResultsMessage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: const Text(
          "No products found.",
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
      ),
    );
  }
}
