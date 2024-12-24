import 'package:shopping_app/entity/product.dart';

class ItemInCart {
  Product product;
  int quantity;

  ItemInCart({
    required this.product,
    this.quantity = 1,
  });
}

class ShoppingCart {
  late List<ItemInCart> items;

  ShoppingCart() {
    items = [];
  }

  void add(Product p, {int quantity = 1}) {
    for (var it in items) {
      if (it.product.id == p.id) {
        it.quantity += quantity;
        return;
      }
    }

    var itTmp = ItemInCart(
      product: p,
      quantity: quantity,
    );
    items.add(itTmp);
  }

  void addItemInCart(Product p, {int quantity = 1}) {
    for (ItemInCart it in items) {
      if (it.product.id == p.id) {
        it.quantity += quantity;
        if (it.quantity == 0) {
          it.quantity = 1;
        }
        return;
      }
    }
  }

  void remove(Product product) {
    items.removeWhere((item) => item.product.id == product.id);
  }

  double getTotal() {
    return items.fold(
        0, (total, item) => total + item.quantity * item.product.price);
  }

  int getQuantityItemInCart(int productId) {
    for (var item in items) {
      if (item.product.id == productId) {
        return item.quantity;
      }
    }
    return 0;
  }
}

ShoppingCart cart = new ShoppingCart();
