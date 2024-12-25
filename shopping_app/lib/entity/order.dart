import 'package:shopping_app/entity/shoppingCart.dart';

class Order {
  String id;
  DateTime date;
  double total;
  int userID;
  String customerName;
  String phoneNumber;
  String customerAddress;
  List<ItemInCart> items;

  Order({
    required this.id,
    required this.date,
    required this.total,
    required this.userID,
    required this.customerName,
    required this.phoneNumber,
    required this.customerAddress,
    required this.items,
  });
}

class OrderManager {
  late List<Order> orders;

  OrderManager() {
    orders = [];
  }

  void addOrder(Order order) {
    orders.add(order);
  }

  Order createOrderFromCart(ShoppingCart cart, String name, String phone,
      String address, int userID) {
    if (cart.items.isEmpty) {
      throw Exception("Cart is empty. Cannot create an order.");
    }

    Order newOrder = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      total: cart.getTotal(),
      userID: userID,
      customerName: name,
      phoneNumber: phone,
      customerAddress: address,
      items: List.from(cart.items), // Sao chép list sản phẩm
    );

    addOrder(newOrder);
    cart.items.clear();
    return newOrder;
  }
}

OrderManager listOrders = new OrderManager();
