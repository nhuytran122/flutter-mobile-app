import 'package:flutter/material.dart';
import 'package:shopping_app/components/appbar.dart';
import 'package:shopping_app/components/cart_item_card.dart';
import 'package:shopping_app/components/total_price_row.dart';
import 'package:shopping_app/entity/common_method.dart';
import 'package:shopping_app/entity/order.dart';
import 'package:shopping_app/my_details_product.dart';
import 'package:shopping_app/utils/navigate_helper.dart';

class OrderDetailScreen extends StatefulWidget {
  static String routeName = "/order_detail";

  final Order order;

  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "Order #${widget.order.id}"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Order ID: ${widget.order.id}"),
            Text("Date: ${CommonMethod.formatDate(widget.order.date)}"),
            Text("Customer Name: ${widget.order.customerName}"),
            Text("Address: ${widget.order.customerAddress}"),
            Text("Phone Number: ${widget.order.phoneNumber}"),
            const SizedBox(height: 20),
            Text(
              "Items:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildListItems(),
            const SizedBox(height: 16),
            TotalPriceRow(
              totalPrice: widget.order.total,
            ),
          ],
        ),
      ),
    );
  }

  ListView _buildListItems() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.order.items.length,
      itemBuilder: (context, index) {
        final item = widget.order.items[index];
        return CartItemCard(
          item: item,
          navigateToProductDetail: (context) {
            navigateToScreenWithPara(
              context,
              ProductDetailPage(productId: item.product.id),
              setState,
            );
          },
        );
      },
    );
  }

  CustomAppBar myAppBar(BuildContext context, String title) {
    return CustomAppBar(
      title: title,
      onBackPressed: () {
        Navigator.pop(context, true);
      },
    );
  }
}
