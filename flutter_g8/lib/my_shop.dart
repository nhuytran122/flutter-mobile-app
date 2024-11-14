import 'package:flutter/material.dart';
import 'package:flutter_g8/entity/product2.dart';
import 'package:flutter_g8/utils/api_service.dart';

class MyShop extends StatefulWidget {
  const MyShop({super.key});

  @override
  State<MyShop> createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  late Future<List<Product2>> lsProduct2;

  @override
  void initState() {
    super.initState();
    lsProduct2 = ApiService.getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: FutureBuilder(
        future: lsProduct2,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            var data = snapshot.data!;
            return MyListView(data);
          }
        },
      ),
    );
  }

  Widget MyListView(List<Product2> ls) {
    return ListView(
      children: ls.map((e) => MyItem(e)).toList(),
    );
  }

  Widget MyItem(Product2 p) {
    return Container(
      child: Card(
        child: ListTile(
          leading: Image.network(
            p.image,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              itemText("Name", "${p.title}"),
              itemText("Category", "${p.category}"),
              itemText("Price", "\$${p.price}"),
            ],
          ),
          trailing: ElevatedButton(
            onPressed: () {
              setState(() {});
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

  AppBar myAppBar() {
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
      actions: [],
    );
  }
}
