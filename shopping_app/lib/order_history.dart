import 'package:flutter/material.dart';
import 'package:shopping_app/entity/appColor.dart';
import 'package:shopping_app/entity/common_method.dart';
import 'package:shopping_app/entity/order.dart';

class OrderHistoryScreen extends StatelessWidget {
  static String routeName = "/order_history";

  static final List<Order> orderHistory = [
    Order(
        id: "1",
        date: DateTime.now().subtract(Duration(days: 1)),
        total: 250000,
        items: ["Item A", "Item B"]),
    Order(
        id: "2",
        date: DateTime.now().subtract(Duration(days: 3)),
        total: 150000,
        items: ["Item C"]),
  ];

  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: orderHistory.isEmpty
          ? Center(
              child: Text(
                "You have no orders yet!",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: orderHistory.length,
              itemBuilder: (context, index) {
                final order = orderHistory[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      "Order #${order.id}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Date: ${CommonMethod.formatDate(order.date)}\n"
                      "Total: ${CommonMethod.formatPrice(order.total)}",
                    ),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      showOrderDetails(context, order);
                    },
                  ),
                );
              },
            ),
    );
  }

  void showOrderDetails(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Order Details"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text("Order ID: ${order.id}"),
              Text("Date: ${CommonMethod.formatDate(order.date)}"),
              Text("Total: ${CommonMethod.formatPrice(order.total)}"),
              SizedBox(height: 16),
              Text("Items:", style: TextStyle(fontWeight: FontWeight.bold)),
              ...order.items.map((item) => Text("- $item")),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
