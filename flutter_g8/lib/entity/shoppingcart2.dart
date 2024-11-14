import 'package:flutter/material.dart';
import 'package:flutter_g8/entity/product2.dart';

class ItemInCart2 {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;
  late int quantity;
  ItemInCart2(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      required this.rating,
      this.quantity = 1});
}

class ShoppingCart2 {
  late List<ItemInCart2> items;
  ShoppingCart2() {
    items = [];
  }

  void add(Product2 p, {int quantity = 1}) {
    for (var it in items) {
      if (it.id == p.id) {
        it.quantity += quantity;
        return;
      }
    }
    var itTmp = ItemInCart2(
        id: p.id,
        title: p.title,
        price: p.price,
        description: p.description,
        category: p.category,
        image: p.image,
        rating: p.rating);
    items.add(itTmp);
  }

  void addItemInCart(ItemInCart2 itc, {int quantity = 1}) {
    for (ItemInCart2 it in items) {
      if (it.id == itc.id) {
        it.quantity += quantity;
        if (it.quantity == 0) {
          it.quantity = 1;
        }
        return;
      }
    }
  }

  void remove(ItemInCart2 itc) {
    items.removeWhere((item) => item.id == itc.id);
  }

  double getTotal() {
    return items.fold(0, (s, item) => s + item.quantity * item.price);
  }
}

ShoppingCart2 shoppingCart2 = new ShoppingCart2();
