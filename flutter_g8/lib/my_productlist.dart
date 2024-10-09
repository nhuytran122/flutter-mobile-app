import 'package:flutter/material.dart';
import 'package:flutter_g8/entity/product.dart';

class MyProductList extends StatelessWidget {
  MyProductList({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  onPressed: () => null,
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  )),
              Positioned(
                right: 5,
                top: 5,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          ),
          IconButton(
              onPressed: () => null,
              icon: Icon(Icons.notifications, color: Colors.white)),
          IconButton(
              onPressed: () => null,
              icon: Icon(Icons.search, color: Colors.amber)),
        ],
      ),
      body: ListView(
        children: listProducts.map((e) => item(e)).toList(),
      ),
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
              // image: DecorationImage(
              //   fit: BoxFit.cover,
              //   opacity: 0.7,
              //   image: NetworkImage(p.avtImage),
              // ),
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
            onPressed: () => null,
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