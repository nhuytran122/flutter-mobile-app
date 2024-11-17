import 'package:flutter/material.dart';
import 'package:flutter_g8/entity/product2.dart';
import 'package:flutter_g8/entity/shoppingcart2.dart';
import 'package:flutter_g8/my_list_prd_category.dart';
import 'package:flutter_g8/my_profile.dart';
import 'package:flutter_g8/utils/api_service.dart';

class MyShopOnline extends StatefulWidget {
  const MyShopOnline({super.key});

  @override
  State<MyShopOnline> createState() => _MyShopOnlineState();
}

class _MyShopOnlineState extends State<MyShopOnline> {
  late Future<List<Product2>> lsProduct2;
  List<Product2> allProducts = [];
  List<String> listCategories = [];
  int currentPage = 0;
  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
    lsProduct2 = ApiService.getAllProduct();
  }

  List<String> getCategories(List<Product2> products) {
    return products.map((product) => product.category).toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(context),
      appBar: myAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: lsProduct2,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  allProducts = snapshot.data!;
                  listCategories = getCategories(allProducts);
                  return MyPageView();
                }
              },
            ),
          ),
          myBuildDotIndicator(),
        ],
      ),
      floatingActionButton: MyFloatingButton(),
    );
  }

  FloatingActionButton MyFloatingButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        print("Pressed");
      },
      icon: Icon(Icons.message),
      label: Text('Message'),
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
    );
  }

  PageView MyPageView() {
    return PageView(
      onPageChanged: (index) {
        setState(() {
          currentPage = index;
        });
      },
      children: [
        GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.7,
          ),
          itemCount: allProducts.length,
          itemBuilder: (context, index) {
            return buildProductCard(allProducts[index]);
          },
        ),
        GridView.builder(
          padding: EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: listCategories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MyListPrdCategory(
                      category: listCategories[index],
                      allProducts: allProducts,
                    ),
                  ),
                );
              },
              child: buildCategoryCard(listCategories[index]),
            );
          },
        )
      ],
    );
  }

  Widget buildProductCard(Product2 p) {
    return Card(
      child: Column(
        children: [
          Image.network(
            p.image,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8),
          Text(
            p.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8),
          Text(
            '\$${p.price}',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
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
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/my_avt.jpg'),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Nhu Y',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '21t1020105@husc.edu.vn',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          myOptionalInDrawer(
            Icons.production_quantity_limits,
            'All Products',
            () {
              allProducts;
              Navigator.pop(context);
            },
          ),
          myOptionalInDrawer(
            Icons.home_outlined,
            'My Profile',
            () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MyProfilePage(),
              ));
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

  ListTile myOptionalInDrawer(
      IconData iconData, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(label),
      onTap: onTap,
    );
  }
}
