import 'package:flutter/material.dart';
import 'package:flutter_g8/entity/product2.dart';
import 'package:flutter_g8/entity/shoppingcart2.dart';
import 'package:flutter_g8/utils/api_service.dart';

class MyShopOnline extends StatefulWidget {
  const MyShopOnline({super.key});

  @override
  State<MyShopOnline> createState() => _MyShopOnlineState();
}

class _MyShopOnlineState extends State<MyShopOnline> {
  late Future<List<Product2>> lsProduct2;
  List<Product2> allProducts = [];
  List<Product2> listProducts = [];
  List<String> listCategories = [];
  int currentPage = 0;
  String selectedCategory = ''; // Phân loại đã chọn

  @override
  void initState() {
    super.initState();
    lsProduct2 = ApiService.getAllProduct();
    lsProduct2.then((products) {
      setState(() {
        allProducts = products;
        listProducts = allProducts;
        listCategories = getCategories(allProducts); // Lấy danh sách phân loại
      });
    });
  }

  List<String> getCategories(List<Product2> products) {
    return products.map((product) => product.category).toSet().toList();
  }

  void getProductsByCategory(String category) {
    setState(() {
      selectedCategory = category;
      listProducts = Product2.filterByCategory(allProducts, selectedCategory);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(context),
      appBar: myAppBar(context),
      body: Column(
        children: [
          Expanded(child: myPageView()), // Đặt PageView trong Expanded
          myBuildDotIndicator(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Floating Action Button Pressed");
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget myPageView() {
    return PageView(
      onPageChanged: (value) {
        setState(() {
          currentPage = value;
        });
      },
      children: [
        SizedBox(
          height: 300,
          child: GridView.builder(
            padding: EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.9,
            ),
            itemCount: listProducts.length,
            itemBuilder: (context, index) {
              return buildProductCard(listProducts[index]);
            },
          ),
        ),
        // Page 2: Display categories
        SizedBox(
          height: 300,
          child: GridView.builder(
            padding: EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
            ),
            itemCount: listCategories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  getProductsByCategory(listCategories[index]);
                },
                child: buildCategoryCard(listCategories[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildProductCard(Product2 p) {
    return Card(
      child: Column(
        children: [
          Image.network(
            p.image,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Text(
            p.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text('\$${p.price}'),
          ElevatedButton(
            onPressed: () {
              setState(() {
                shoppingCart2.add(p);
              });
            },
            child: Text("Add to cart"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryCard(String category) {
    return Card(
      color: Colors.blueAccent,
      child: Center(
        child: Text(
          category,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Row myBuildDotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        2,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 1),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: currentPage == index ? Colors.blue : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      title: Text(
        "PRODUCT LIST",
        style: TextStyle(
          color: Colors.white,
        ),
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
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
            ),
            shoppingCart2.items.length == 0 ? SizedBox.shrink() : myIconCart(),
          ],
        ),
        IconButton(
          onPressed: () => null,
          icon: Icon(Icons.notifications, color: Colors.white),
        ),
        IconButton(
          onPressed: () => null,
          icon: Icon(Icons.search, color: Colors.amber),
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
            '${shoppingCart2.items.length}',
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

  Widget myDrawer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 2 / 3,
      decoration: BoxDecoration(color: Colors.white),
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'SHOPPING',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          myOptionalInDrawer(
            Icons.production_quantity_limits,
            'All Products',
            () {},
          ),
          myOptionalInDrawer(
            Icons.home_outlined,
            'My Profile',
            () {},
          ),
          Divider(),
          myOptionalInDrawer(Icons.contact_emergency, 'Contact', () {}),
          myOptionalInDrawer(Icons.settings_outlined, 'Setting', () {}),
          myOptionalInDrawer(Icons.help_outline, 'Help', () {}),
        ],
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
