import 'package:flutter/material.dart';
import 'package:flutter_g8/entity/product2.dart';
import 'package:flutter_g8/entity/shoppingcart2.dart';

class MyListPrdCategory extends StatefulWidget {
  final String category;
  final List<Product2> allProducts;

  MyListPrdCategory({required this.category, required this.allProducts});

  @override
  State<MyListPrdCategory> createState() => _MyListPrdCategoryState();
}

class _MyListPrdCategoryState extends State<MyListPrdCategory> {
  @override
  Widget build(BuildContext context) {
    List<Product2> products =
        Product2.filterByCategory(widget.allProducts, widget.category);

    return Scaffold(
      appBar: myAppBar(context),
      drawer: myDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.7,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return buildProductCard(products[index]);
          },
        ),
      ),
    );
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
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
      title: Text(
        "${widget.category}",
        style: TextStyle(color: Colors.white),
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
            () {
              Navigator.pop(context);
            },
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
}
