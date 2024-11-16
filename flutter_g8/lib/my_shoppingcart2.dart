import 'package:flutter/material.dart';
import 'package:flutter_g8/entity/product2.dart';
import 'package:flutter_g8/entity/shoppingcart2.dart';

class MyShoppingCart2 extends StatefulWidget {
  const MyShoppingCart2({super.key});

  @override
  State<MyShoppingCart2> createState() => _MyShoppingCart2State();
}

class _MyShoppingCart2State extends State<MyShoppingCart2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Column(
        children: [
          shoppingCart2.items.isNotEmpty
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

  Widget myShoppingCart() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: shoppingCart2.items.map((e) => item(e)).toList(),
        ),
      ),
    );
  }

  Container myBottom() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 245, 220, 220),
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
                Text("\$${shoppingCart2.getTotal().toStringAsFixed(2)}"),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,
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
          Navigator.pop(context, true);
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 30,
        ),
      ),
      title: Text(
        "My Shopping Cart",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Stack(
            children: [
              IconButton(
                onPressed: () => null,
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              ),
              shoppingCart2.items.length == 0
                  ? SizedBox.shrink()
                  : myIconCart(),
            ],
          ),
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

  Widget item(ItemInCart2 it) {
    return Container(
      child: Card(
        child: ListTile(
          leading: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(it.image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${it.title}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text("\$${it.price.toStringAsFixed(2)}"),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        shoppingCart2.addItemInCart(it, quantity: -1);
                      });
                    },
                    icon: Icon(Icons.remove),
                  ),
                  Text("${it.quantity}"),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        shoppingCart2.addItemInCart(it, quantity: 1);
                      });
                    },
                    icon: Icon(Icons.add),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        shoppingCart2.remove(it);
                      });
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ],
              ),
              SizedBox(
                width: 80,
                child: Text(
                  "\$${(it.price * it.quantity).toStringAsFixed(2)}",
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
