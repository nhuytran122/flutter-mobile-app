import 'package:flutter/material.dart';
import 'package:flutter_g8/entity/shoppingcart.dart';

class MyShoppingCart extends StatefulWidget {
  const MyShoppingCart({super.key});

  @override
  State<MyShoppingCart> createState() => _MyShoppingCartState();
}

class _MyShoppingCartState extends State<MyShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Column(
        children: [
          shoppingCart.items.length > 0
              ? myShoppingCart()
              : myEmptyShoppingCart(),
          myBottom(),
        ],
      ),
    );
  }

  Widget myEmptyShoppingCart() {
    return Expanded(
      child: Center(
        child: Text(
          "YOUR CART IS EMPTY",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Expanded myShoppingCart() {
    return Expanded(
      child: ListView(
        children: List.generate(10, (index) => item()),
      ),
    );
  }

  Container myBottom() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.red,
      ),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sub total:"),
                Text("\$50.00"),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: Center(
                child: Text(
                  "Proceed to Pay",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          )),
      title: Text(
        "My Shopping Cart",
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
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
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
      ],
    );
  }

  Widget item() {
    return Container(
      child: Card(
        child: ListTile(
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: KIWI"),
                  Text("Unit: Kg"),
                  Text("Price: \$20"),
                ],
              ),
              Row(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => null,
                        icon: Icon(Icons.remove),
                      ),
                      Text("2"),
                      IconButton(
                        onPressed: () => null,
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => null,
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
