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
    return ListTile(title: Text(p.title));
  }
}
