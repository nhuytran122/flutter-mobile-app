import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/components/appbar.dart';
import 'package:shopping_app/components/cart_item_card.dart';
import 'package:shopping_app/components/input_field.dart';
import 'package:shopping_app/components/total_price_row.dart';
import 'package:shopping_app/entity/appColor.dart';
import 'package:shopping_app/entity/common_method.dart';
import 'package:shopping_app/entity/order.dart';
import 'package:shopping_app/entity/shoppingCart.dart';
import 'package:shopping_app/my_details_product.dart';
import 'package:shopping_app/thank_you.dart';
import 'package:shopping_app/utils/navigate_helper.dart';
import 'package:shopping_app/utils/user_provider.dart';

class CheckOutScreen extends StatefulWidget {
  static String routeName = "/check_out";

  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void userTappedConfirm() {
    final userData = Provider.of<UserProvider>(context, listen: false).userData;
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Confirm payment"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Full Name: ${fullNameController.text}"),
                Text("Phone Number: ${phoneNumberController.text}"),
                Text("Address: ${addressController.text}"),
                Text(
                    "Total Price: ${CommonMethod.formatPrice(cart.getTotal())}"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Order order = listOrders.createOrderFromCart(
                    cart,
                    fullNameController.text,
                    phoneNumberController.text,
                    addressController.text,
                    userData!.id);
                navigateToScreenWithPara(
                  context,
                  ThankYouScreen(order: order),
                  setState,
                );
              },
              child: Text("Confirm"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "Checkout"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildFormInput(),
            SizedBox(height: 5),
            _buildListItems(),
            TotalPriceRow(
              totalPrice: cart.getTotal(),
            ),
            SizedBox(height: 8),
            SizedBox(
              width: double.infinity, // chiếm toàn bộ chiều ngang
              child: buildButtonConfirm(),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildListItems() {
    return Expanded(
      child: ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (context, index) {
          var item = cart.items[index];
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
      ),
    );
  }

  Form _buildFormInput() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          MyCustomInputField(
            labelText: 'Full Name',
            iconData: Icons.person,
            hintText: 'Enter your full name',
            obscureText: false,
            controller: fullNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
          ),
          SizedBox(height: 32),
          MyCustomInputField(
            labelText: 'Phone Number',
            iconData: Icons.phone,
            hintText: 'Enter your phone number',
            obscureText: false,
            controller: phoneNumberController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          SizedBox(height: 32),
          MyCustomInputField(
            labelText: 'Address',
            iconData: Icons.location_on,
            hintText: 'Enter your address',
            obscureText: false,
            controller: addressController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  ElevatedButton buildButtonConfirm() {
    return ElevatedButton(
      onPressed: userTappedConfirm,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: const EdgeInsets.all(16),
      ),
      child: const Text(
        'Confirm Order',
        style: TextStyle(fontSize: 18.0, color: Colors.white),
      ),
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
