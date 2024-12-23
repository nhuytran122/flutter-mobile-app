import 'package:shopping_app/entity/product.dart';

class ItemInCart {
  int id;
  String title;
  String category;
  double price;
  double discountPercentage;
  int stock;
  String? brand;
  int weight;
  String availabilityStatus;
  String thumbnail;

  late int quantity; // Số lượng sản phẩm trong giỏ

  ItemInCart(
    this.id,
    this.title,
    this.category,
    this.price,
    this.discountPercentage,
    this.stock,
    this.brand,
    this.weight,
    this.availabilityStatus,
    this.thumbnail, {
    this.quantity = 1, // Mặc định là 1 sản phẩm
  });
}

class ShoppingCart {
  late List<ItemInCart> items;

  ShoppingCart() {
    items = [];
  }

  void add(Product p, {int quantity = 1}) {
    for (var it in items) {
      if (it.id == p.id) {
        it.quantity += quantity;
        return;
      }
    }

    var itTmp = ItemInCart(
      p.id,
      p.title,
      p.category,
      p.price,
      p.discountPercentage,
      p.stock,
      p.brand,
      p.weight,
      p.availabilityStatus,
      p.thumbnail,
      quantity: quantity,
    );
    items.add(itTmp);
  }

  void addItemInCart(ItemInCart itc, {int quantity = 1}) {
    for (ItemInCart it in items) {
      if (it.id == itc.id) {
        it.quantity += quantity;
        if (it.quantity == 0) {
          it.quantity = 1;
        }
        return;
      }
    }
  }

  void remove(ItemInCart itc) {
    items.removeWhere((item) => item.id == itc.id);
  }

  double getTotal() {
    return items.fold(0, (s, item) => s + item.quantity * item.price);
  }

  int getQuantityItemInCart(int productId) {
    for (var item in items) {
      if (item.id == productId) {
        return item.quantity;
      }
    }
    return 0;
  }
}

ShoppingCart cart = new ShoppingCart();
