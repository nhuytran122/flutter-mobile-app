import 'package:flutter/material.dart';
import 'package:flutter_g8/entity/product.dart';

class ItemInCart {
  late String name;
  late String unit;
  late double price;
  late String avtImage;
  late Color avtColor;
  late int quantity;
  ItemInCart(
      {required this.name,
      required this.unit,
      required this.price,
      required this.avtColor,
      required this.avtImage,
      this.quantity = 1});
}

class ShoppingCart {
  late List<ItemInCart> items;
  ShoppingCart() {
    items = [];
  }

  void add(Product product, {int quantity = 1}) {
    for (var it in items) {
      if (it.name == product.name) {
        it.quantity += quantity;
        return;
      }
    }
    var itTmp = ItemInCart(
        name: product.name,
        unit: product.unit,
        price: product.price,
        avtColor: product.avtColor,
        avtImage: product.avtImage);
    items.add(itTmp);
  }

  void addItemInCart(ItemInCart itc, {int quantity = 1}){
        for (ItemInCart it in items) {
          if (it.name == itc.name) {
            it.quantity += quantity;
            if(it.quantity == 0){
              it.quantity = 1;
            }
            return;
          }
    }
  }

  // void remove(ItemInCart item, {int quantity = 1}) {
  //   for (ItemInCart it in items) {
  //     if (it.name == item.name) {
  //       it.quantity -= 1;

  //       if (it.quantity <= 0) {
  //         items.remove(it);
  //       }
  //     }
  //   }
  // }

  void remove(ItemInCart itc){
    items.removeWhere((item) => item.name == itc.name );
  }

  // void delete(ItemInCart item) {
  //   for (ItemInCart it in items) {
  //     if (it.name == item.name) {
  //       items.remove(it);
  //       break;
  //     }
  //   }
  // }

  // double getTotal() {
  //   double total = 0;
  //   for (ItemInCart it in items) {
  //     total += it.price * it.quantity;
  //   }
  //   return total;
  // }
  double getTotal() {
    return items.fold(0, (s, item) => s + item.quantity * item.price);
  }
}

ShoppingCart shoppingCart = new ShoppingCart();
