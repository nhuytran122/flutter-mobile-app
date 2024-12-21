import 'package:flutter/material.dart';
import 'package:shopping_app/entity/appColor.dart';
import 'package:shopping_app/entity/constants.dart';
import 'package:shopping_app/entity/my_product.dart';
import 'package:shopping_app/entity/product.dart';
import 'package:shopping_app/my_profile.dart';
import 'package:shopping_app/utils/api_service.dart';

class MyShop extends StatefulWidget {
  final Map<String, dynamic> userData;

  const MyShop({Key? key, required this.userData}) : super(key: key);

  @override
  State<MyShop> createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  late List<Product> allProducts = [];
  List<Product> filteredProducts = [];
  List<String> listCategories = [];
  List<String> listTags = [];
  bool noResultsFound = false;
  List<String> selectedTags = [];
  List<Product> discountedProducts = [];
  String searchQuery = "";

  late Future<List<Product>> lsProduct;

  @override
  void initState() {
    super.initState();
    lsProduct = ApiService.getAllProduct();
  }

  List<String> getListCategories(List<Product> products) {
    return products.map((product) => product.category).toSet().toList();
  }

  List<String> getListTags(List<Product> products) {
    final tags = <String>{};
    for (var product in products) {
      if (product.tags != null) {
        tags.addAll(product.tags!);
      }
    }
    return tags.toList();
  }

  void filterProducts() {
    setState(() {
      filteredProducts = allProducts.where((product) {
        final matchesTags = selectedTags.isEmpty ||
            (product.tags != null &&
                product.tags!.any((tag) => selectedTags.contains(tag)));
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
      body: FutureBuilder<List<Product>>(
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
            discountedProducts =
                allProducts.where((product) => product.price < 30).toList();
            listCategories = getListCategories(allProducts);
            listTags = getListTags(allProducts);

            return ListView(
              children: [
                buildCategories(),
                buildTags(),
                buildTitle("Top Products Discounted"),
                buildDiscountedProducts(),
                buildTitle("All Products"),
                noResultsFound
                    ? buildNoResultsMessage()
                    : buildProductList(filteredProducts),
              ],
            );
          }
        },
      ),
    );
  }

  Widget buildCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: MediaQuery.of(context)
            .size
            .width, // Đảm bảo toàn màn hình được sử dụng
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: listCategories.map((category) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  print('Selected category: $category');
                },
                child: buildCategoryCard(Icons.category, category),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildTags() {
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

  Widget buildDiscountedProducts() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: discountedProducts.map((product) {
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

  Widget buildTitle(String title) {
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
          const Text("See more"),
        ],
      ),
    );
  }

  Widget buildProductCard(Product p) {
    return Card(
      child: Column(
        children: [
          Image.network(
            p.thumbnail,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
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
              print("Added ${p.title} to cart");
            },
            child: const Text("Add to cart"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
        ],
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
              onChanged: (value) {
                searchQuery = value;
                filterProducts();
              },
              decoration: const InputDecoration(
                hintText: 'Search products...',
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
                Navigator.pushNamed(context, "/shoppingcart2").then((value) {
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
            2 == 0 ? const SizedBox.shrink() : myIconCart(),
          ],
        ),
      ],
    );
  }

  Widget myDrawer(BuildContext context) {
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
                    widget.userData['image'] ??
                        'https://via.placeholder.com/150',
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
                        '${widget.userData["firstName"] ?? ''} ${widget.userData["lastName"] ?? ''}'
                                .trim()
                                .isEmpty
                            ? 'Guest'
                            : '${widget.userData["firstName"] ?? ''} ${widget.userData["lastName"] ?? ''}'
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
                        widget.userData['email'] ?? '',
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
            'My Profile',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MyProfilePage(userData: widget.userData),
                ),
              );
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
        child: const Center(
          child: Text(
            '2', // Placeholder for shopping cart item count
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
