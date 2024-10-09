import 'package:flutter/material.dart';

class Product {
  late String name;
  late String unit;
  late double price;
  late String avtImage;
  late Color avtColor;
  Product(this.name, this.unit, this.price,
      {this.avtImage = "", this.avtColor = Colors.amber});
}

var listProducts = [
  Product("Apple", "Kg", 20, avtColor: const Color.fromARGB(255, 154, 32, 23)),
  Product("Mango", 'Doz', 30, avtColor: const Color.fromARGB(174, 248, 192, 8)),
  Product("Banana", "Doz", 10, avtColor: Colors.yellow),
  Product("Grapes", "Kg", 8, avtColor: Colors.purple),
  Product("Watermelon", "Kg", 25, avtColor: Colors.red),
  Product("Kiwi", "Pc", 40, avtColor: Colors.green),
  Product("Orange", "Doz", 15, avtColor: Colors.orange),
];
