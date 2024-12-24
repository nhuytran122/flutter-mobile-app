import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/discounted_products.dart';

import 'package:shopping_app/entity/appColor.dart';
import 'package:shopping_app/entity/category.dart';
import 'package:shopping_app/entity/product.dart';
import 'package:shopping_app/entity/shoppingCart.dart';
import 'package:shopping_app/entity/user.dart';
import 'package:shopping_app/filter_products_by_category.dart';
import 'package:shopping_app/my_cart.dart';
import 'package:shopping_app/my_details_product.dart';
import 'package:shopping_app/my_profile.dart';
import 'package:shopping_app/order_history.dart';
import 'package:shopping_app/utils/api_service.dart';
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
                    return buildCategories(snapshot.data!);
                  }
                },
              ),
              buildTags(listTags),
              buildTitle(
                "Top Products Discounted",
                true,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DiscountedProductsScreen(
                          discountedProducts: discountedProducts),
                    ),
                  ).then((value) {
                    if (value == true) {
                      setState(() {});
                    }
                  });
                },
              ),
              buildTopSales(getTopSaleProducts(allProducts).take(5).toList()),
              buildTitle(
                "All Products",
                false,
                null,
              ),
              noResultsFound
                  ? buildNoResultsMessage()
                  : buildProductList(filteredProducts),
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
      drawer: myDrawer(context),
      appBar: myAppBar(context),
      body: _getBodyContent(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Orders History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "My Profile",
          ),
        ],
      ),
    );
  }

  Widget buildCategories(List<Category> listCategories) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: listCategories.map((category) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CategoryProductsScreen(category: category.slug),
                  ),
                ).then((value) {
                  if (value == true) {
                    setState(() {});
                  }
                });
                ;
              },
              child: buildCategoryCard(Icons.category, category.name),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildTags(List<String> listTags) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(bottom: 16),
        child: Row(
          children: listTags.map((tag) {
            final isSelected = selectedTags.contains(tag);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ChoiceChip(
                label: Text(tag),
                selected: isSelected,
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
                selectedColor: Colors.blue.shade100,
                backgroundColor: Colors.grey.shade200,
                labelStyle: TextStyle(
                  color: isSelected ? AppColors.primary : Colors.black,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildTopSales(List<Product> lstTopSales) {
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
                child: buildProductCard(product),
              ),
            );
          }).toList(),
        ),
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

  Widget buildTitle(String title, bool seeMore,
      [VoidCallback? onSeeMorePressed]) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (seeMore)
            GestureDetector(
              onTap: onSeeMorePressed ?? () {},
              child: const Text(
                "See more",
                style: TextStyle(
                  color: AppColors.secondary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildProductCard(Product p) {
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
      child: Container(
        width: 150,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Image.network(
                    p.thumbnail,
                    height: 80,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                  if (p.discountPercentage > 0)
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
                          '${p.discountPercentage.toStringAsFixed(0)}%',
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  p.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                    cart.add(p, quantity: 1);
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
      ),
    );
  }

  Widget buildCategoryCard(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFEEE8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.orange,
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      title: Row(
        children: [
          Expanded(
            child: TextField(
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
            ),
          ),
        ],
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, MyShoppingCart.routeName)
                    .then((value) {
                  if (value == true) {
                    setState(() {}); // Cập nhật khi quay về
                  }
                });
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
            ),
            cart.items.length == 0 ? SizedBox.shrink() : myIconCart(),
          ],
        ),
      ],
    );
  }

  Widget myDrawer(BuildContext context) {
    final userData = Provider.of<UserProvider>(context).userData;
    return Container(
      width: MediaQuery.of(context).size.width * 2 / 3,
      decoration: const BoxDecoration(color: Colors.white),
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primary,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    userData?.image ?? 'assets/images/default-avatar.jpg',
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${userData?.firstName ?? ''} ${userData?.lastName ?? ''}'
                                .trim()
                                .isEmpty
                            ? 'Guest'
                            : '${userData?.firstName ?? ''} ${userData?.lastName ?? ''}'
                                .trim(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        userData?.email ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          myOptionalInDrawer(
            Icons.home_outlined,
            'Home',
            () {
              setState(() {
                _selectedIndex = 0;
              });
              Navigator.pop(context);
            },
          ),
          myOptionalInDrawer(
            Icons.home_outlined,
            'My Profile',
            () {
              setState(() {
                _selectedIndex = 2;
              });
              Navigator.pop(context);
            },
          ),
          Divider(),
          myOptionalInDrawer(Icons.contact_emergency, 'Contact', () {}),
          myOptionalInDrawer(Icons.settings_outlined, 'Setting', () {}),
          myOptionalInDrawer(Icons.help_outline, 'Help', () {}),
        ],
      ),
    );
  }

  Positioned myIconCart() {
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

  Widget buildNoResultsMessage() {
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

  ListTile myOptionalInDrawer(
      IconData iconData, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(label),
      onTap: onTap,
    );
  }
}
