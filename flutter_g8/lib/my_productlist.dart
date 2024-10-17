import 'package:flutter/material.dart';
import 'package:flutter_g8/entity/product.dart';
import 'package:flutter_g8/entity/shoppingcart.dart';

class MyProductList extends StatefulWidget {
  MyProductList({super.key});

  @override
  State<MyProductList> createState() => _MyProductListState();
}

class _MyProductListState extends State<MyProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: ListView(
        children: listProducts.map((e) => item(e)).toList(),
      ),
    );
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      leading: IconButton(
        onPressed: () => null,
        icon: Icon(
          Icons.home,
          color: Colors.white,
          size: 30,
        ),
      ),
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
                Navigator.pushNamed(context, "/shoppingcart").then((value) {
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
            Positioned(
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
                    '${shoppingCart.items.length}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
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

  Widget item(Product p) {
    return Container(
      child: Card(
        child: ListTile(
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: p.avtColor,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              itemText("Name", "${p.name}"),
              itemText("Unit", "${p.unit}"),
              itemText("Price", "${p.price}"),
            ],
          ),
          trailing: ElevatedButton(
            onPressed: () {
              setState(() {
                shoppingCart.add(p);
              });
            },
            child: Text("Add to cart"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Text itemText(String label, String value) {
    return Text.rich(TextSpan(text: "${label}: ", children: [
      TextSpan(
          text: "${value}",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ))
    ]));
  }
}
