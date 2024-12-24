import 'package:flutter/material.dart';
import 'package:shopping_app/entity/common_method.dart';
import 'package:shopping_app/entity/order.dart';
import 'package:shopping_app/order_detail.dart';

class OrderHistoryScreen extends StatefulWidget {
  static String routeName = "/order_history";

  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listOrders.orders.isEmpty
          ? Center(
              child: Text(
                "You have no orders yet!",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: listOrders.orders.length,
              itemBuilder: (context, index) {
                final order = listOrders.orders[index];
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailScreen(order: order),
                        ),
                      ).then((value) {
                        if (value == true) {
                          setState(() {});
                        }
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}
